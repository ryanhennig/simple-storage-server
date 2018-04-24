require 'json'



MyApp.add_route('DELETE', '/v1/files/{filename}', {
  "resourcePath" => "/File",
  "summary" => "Deletes a file",
  "nickname" => "delete_file", 
  "responseClass" => "void", 
  "endpoint" => "/files/{filename}", 
  "notes" => "",
  "parameters" => [
    {
      "name" => "filename",
      "description" => "name of the file to delete",
      "dataType" => "string",
      "paramType" => "path",
    },
    {
      "name" => "x_session",
      "description" => "Session token given at login",
      "dataType" => "string",
      "paramType" => "header",
    },
    ]}) do
  cross_origin
  # the guts live here

  {"message" => "yes, it worked"}.to_json
end


MyApp.add_route('GET', '/v1/files/{filename}', {
  "resourcePath" => "/File",
  "summary" => "download a file",
  "nickname" => "get_file_by_name", 
  "responseClass" => "file", 
  "endpoint" => "/files/{filename}", 
  "notes" => "Returns a single file",
  "parameters" => [
    {
      "name" => "filename",
      "description" => "name of the file",
      "dataType" => "string",
      "paramType" => "path",
    },
    {
      "name" => "x_session",
      "description" => "Session token given at login",
      "dataType" => "string",
      "paramType" => "header",
    },
    ]}) do
  cross_origin
  # the guts live here

  {"message" => "yes, it worked"}.to_json
end


MyApp.add_route('GET', '/v1/files', {
  "resourcePath" => "/File",
  "summary" => "List the user's files",
  "nickname" => "list_user_files", 
  "responseClass" => "array[string]", 
  "endpoint" => "/files", 
  "notes" => "",
  "parameters" => [
    {
      "name" => "x_session",
      "description" => "Session token given at login",
      "dataType" => "string",
      "paramType" => "header",
    },
    ]}) do
  cross_origin
  
  content_type "application/json"

  req = request_headers

  if not req.include? "x_session"
    status 403
    return {"error" => "x_session parameter missing. headers: #{req.inspect}"}.to_json
  end
  
  token = req["x_session"].to_s
  if not token
    status 403
    return {"error" => "token value missing"}.to_json
  end
  
  db = MyApp.database

  all_users = db.execute("SELECT username, session_token FROM users") 

  # This doesn't work for some reason, so the workaround is to use interpolation and
  # use a character whitelist to prevent SQL injection.
  # results = db.execute("SELECT username FROM users WHERE session_token = ? ", [token])

  if not /^[a-f0-9]+$/ === token
    status 403    
    return {"error" => "session token #{token} is invalid."}.to_json    
  end

  results = db.execute("SELECT username FROM users WHERE session_token = '#{token}' ")
  if results.length == 0
    status 403    
    # return {"error" => "session token #{token} not found. results: #{results}
    # all_users: #{all_users}"}.to_json
  end

  username = results[0][0]

  if not username
    status 403  end

  file_list = FileStorage.get_filenames(username)
  file_list.to_json
end


MyApp.add_route('POST', '/v1/files/{filename}', {
  "resourcePath" => "/File",
  "summary" => "uploads a file",
  "nickname" => "upload_file", 
  "responseClass" => "void", 
  "endpoint" => "/files/{filename}", 
  "notes" => "",
  "parameters" => [
    {
      "name" => "filename",
      "description" => "name of the file",
      "dataType" => "string",
      "paramType" => "path",
    },
    {
      "name" => "x_session",
      "description" => "Session token given at login",
      "dataType" => "string",
      "paramType" => "header",
    },
    ]}) do
  cross_origin
  # the guts live here

  {"message" => "yes, it worked"}.to_json
end

