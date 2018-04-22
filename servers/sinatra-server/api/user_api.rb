require 'json'


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
  
  username = data.fetch("username", nil)
  if not username or username.length < 3 or username.length > 20
    status 400
    content_type "application/json"
    return { error: "Invalid username"}.to_json
  end
  
  password = data.fetch("password", nil)
  if not password or password.length < 8
    status 400
    content_type "application/json"
    return { error: "Invalid password"}.to_json
  end
  # ["X-Content-Type-Options", "Server", "Date", "Connection"].each do |header|
  #   # response[header] = ""
  #   response.headers.delete header
  # end
  
  status 204

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
  # the guts live here

  {"message" => "yes, it worked"}.to_json
end

