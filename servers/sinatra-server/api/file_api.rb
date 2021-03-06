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

  username, error = get_user_from_session
  if error
    status 403
    return {"error" => error}.to_json
  end
  
  filename = params[:filename]
    
  if not /^[\w\-. ]+$/ === filename
    status 403
    # content_type "application/json"
    # return {error: "Invalid filename"}.to_json
  end
  
  error = MyApp.file_storage.delete_file(username, filename)
  
  status 204
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
  
  username, error = get_user_from_session
  if error
    status 403
    return {"error" => error}.to_json
  end

  file_list = MyApp.file_storage.get_filenames(username)
  file_list.to_json
end


MyApp.add_route('PUT', '/v1/files/{filename}', {
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
  
  username, error = get_user_from_session
  if error
    status 403
    return {"error" => error}.to_json
  end
  
  filename = params[:filename]
  
  if not /^[\w\-. ]+$/ === filename
    status 403
    content_type "application/json"
    return {error: "Invalid filename"}.to_json
  end
  
  file_content = request.body.read
  
  error = MyApp.file_storage.write_file(username, filename, file_content)
  
  if error
    status 403
    return {"error" => error}.to_json
  end
    
  status 201
  headers["Location"] = "/files/#{filename}"

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
  
  status 404
  content_type "application/json"
  
  username, error = get_user_from_session
  if error
    return {"error" => error}.to_json
  end
  
  filename = params[:filename]
  
  if not /^[\w\-. ]+$/ === filename
    return {error: "Invalid filename"}.to_json
  end
  
  file_content, error = MyApp.file_storage.read_file(username, filename)
  if error
    return {"error" => error}.to_json
  end

  status 200
  content_type "application/octet-stream"
  return file_content

end

