# SwaggerClient::UserApi

All URIs are relative to *http://localhost/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**create_user**](UserApi.md#create_user) | **POST** /register | Create a new user
[**login_user**](UserApi.md#login_user) | **POST** /login | Logs user into the system


# **create_user**
> create_user(body)

Create a new user

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::UserApi.new

body = SwaggerClient::User.new # User | user object to create


begin
  #Create a new user
  api_instance.create_user(body)
rescue SwaggerClient::ApiError => e
  puts "Exception when calling UserApi->create_user: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**User**](User.md)| user object to create | 

### Return type

nil (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined



# **login_user**
> SessionToken login_user(body)

Logs user into the system



### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::UserApi.new

body = SwaggerClient::User.new # User | user object to create


begin
  #Logs user into the system
  result = api_instance.login_user(body)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling UserApi->login_user: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**User**](User.md)| user object to create | 

### Return type

[**SessionToken**](SessionToken.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



