# SwaggerClient::FileApi

All URIs are relative to *http://localhost/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**delete_file**](FileApi.md#delete_file) | **DELETE** /files/{filename} | Deletes a file
[**get_file_by_name**](FileApi.md#get_file_by_name) | **GET** /files/{filename} | download a file
[**list_user_files**](FileApi.md#list_user_files) | **GET** /files | List the user&#39;s files
[**upload_file**](FileApi.md#upload_file) | **POST** /files/{filename} | uploads a file


# **delete_file**
> delete_file(x_session, filename)

Deletes a file



### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::FileApi.new

x_session = "x_session_example" # String | Session token given at login

filename = "filename_example" # String | name of the file to delete


begin
  #Deletes a file
  api_instance.delete_file(x_session, filename)
rescue SwaggerClient::ApiError => e
  puts "Exception when calling FileApi->delete_file: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **x_session** | **String**| Session token given at login | 
 **filename** | **String**| name of the file to delete | 

### Return type

nil (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **get_file_by_name**
> File get_file_by_name(x_session, filename)

download a file

Returns a single file

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::FileApi.new

x_session = "x_session_example" # String | Session token given at login

filename = "filename_example" # String | name of the file


begin
  #download a file
  result = api_instance.get_file_by_name(x_session, filename)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling FileApi->get_file_by_name: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **x_session** | **String**| Session token given at login | 
 **filename** | **String**| name of the file | 

### Return type

**File**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined



# **list_user_files**
> Array&lt;String&gt; list_user_files(x_session)

List the user's files

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::FileApi.new

x_session = "x_session_example" # String | Session token given at login


begin
  #List the user's files
  result = api_instance.list_user_files(x_session)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling FileApi->list_user_files: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **x_session** | **String**| Session token given at login | 

### Return type

**Array&lt;String&gt;**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **upload_file**
> upload_file(x_session, filename, opts)

uploads a file



### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::FileApi.new

x_session = "x_session_example" # String | Session token given at login

filename = "filename_example" # String | name of the file

opts = { 
  file: File.new("/path/to/file.txt") # File | file to upload
}

begin
  #uploads a file
  api_instance.upload_file(x_session, filename, opts)
rescue SwaggerClient::ApiError => e
  puts "Exception when calling FileApi->upload_file: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **x_session** | **String**| Session token given at login | 
 **filename** | **String**| name of the file | 
 **file** | **File**| file to upload | [optional] 

### Return type

nil (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json



