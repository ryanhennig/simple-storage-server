require 'json'
require 'sqlite3'
require 'securerandom'
require 'bcrypt'
  
MyApp.add_route('POST', '/v1/register', {
  "resourcePath" => "/User",
  "summary" => "Create a new user",
  "nickname" => "create_user", 
  "responseClass" => "void", 
  "endpoint" => "/register", 
  "notes" => "",
  "parameters" => [
    {
      "name" => "body",
      "description" => "user object to create",
      "dataType" => "User",
      "paramType" => "body",
    }
    ]}) do
  cross_origin
  # the guts live here
  
  body = request.body.read
  data = JSON.parse(body)

  status 400  
  content_type "application/json"
  
  username = data.fetch("username", nil)
  if not username or username.length < 3 or username.length > 20
    return { error: "Invalid username"}.to_json
  end
  
  if not /^[\w]+$/ === username
    return { error: "Username has invalid characters"}.to_json
  end
  
  password = data.fetch("password", nil)
  if not password or password.length < 8
    return { error: "Invalid password"}.to_json
  end
  
  db = MyApp.database
  
  # Check if user already exists
  user_exists = false
  db.execute( "SELECT COUNT(*) FROM users WHERE username = ?", [username] ) do |row|
    if row[0] != 0
      user_exists = true
    end
  end
  
  if user_exists
    return { error: "User already exists"}.to_json
  end
  
  # Create password hash

  password_hash = BCrypt::Password.create(password)
  
  
  # Store user in DB w/ SQL injection protection
  db.execute("INSERT INTO users (username, password_hash) 
              VALUES (?, ?)", [username, password_hash.to_s])
  
  
  # ["X-Content-Type-Options", "Server", "Date", "Connection"].each do |header|
  #   # response[header] = ""
  #   response.headers.delete header
  # end
  
  status 204
  return ""
end


MyApp.add_route('POST', '/v1/login', {
  "resourcePath" => "/User",
  "summary" => "Logs user into the system",
  "nickname" => "login_user", 
  "responseClass" => "SessionToken", 
  "endpoint" => "/login", 
  "notes" => "",
  "parameters" => [
    {
      "name" => "body",
      "description" => "user object to create",
      "dataType" => "User",
      "paramType" => "body",
    }
    ]}) do
  cross_origin
  content_type "application/json"

  body = request.body.read
  data = JSON.parse(body)
  
  username = data.fetch("username", nil)  
  password = data.fetch("password", nil)
  if not username or not password
    status 403
    return { error: "Must provide username and password"}.to_json
  end

  db = MyApp.database
  
  # Check if user already exists
  user_found = false
  password_hash = nil
  db.execute( "SELECT password_hash FROM users WHERE username = ?", [username] ) do |row|
    user_found = true
    password_hash = row[0]
  end
  
  if user_found
    #Verify password
    bcrypt_password = BCrypt::Password.new(password_hash)
    if bcrypt_password == password
      
      #Return the existing token if it exists
      token = nil
      db.execute("SELECT session_token FROM users WHERE username = ?", [username]) do |row|
        token = row[0]
      end
      
      if not token
        begin
          token = SecureRandom.hex
          regenerate = false
          db.execute("SELECT username FROM users WHERE session_token = ?", [token]) do |row|
            regenerate = true
          end
        end while regenerate
      
        db.execute("UPDATE users SET session_token = ? WHERE username = ? ", [token, username])
      end
      
      return { token: token.to_s}.to_json
    else
      status 403
      return { error: "Invalid password"}.to_json
    end
  end

  {"message" => "yes, it worked"}.to_json
end

MyApp.add_route('POST', '/v1/unregister', {
  "resourcePath" => "/User",
  "summary" => "Deletes user from the system",
  "nickname" => "delete_user", 
  "responseClass" => "SessionToken", 
  "endpoint" => "/unregister", 
  "notes" => "",
  "parameters" => [
    {
      "name" => "body",
      "description" => "user object to create",
      "dataType" => "User",
      "paramType" => "body",
    }
    ]}) do
  cross_origin

  body = request.body.read
  data = JSON.parse(body)

  #TODO: This method is horribly unsecure for now but convenient for testing  
  username = data.fetch("username", nil)

  if username
    db = MyApp.database

    MyApp.file_storage.delete_all_files(username)

    db.execute( "DELETE FROM users WHERE username = ?", [username] )  
  end
  
  content_type "application/json"
  {"message" => "yes, it worked"}.to_json
end

