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

  {"message" => "yes, it worked"}.to_json
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

