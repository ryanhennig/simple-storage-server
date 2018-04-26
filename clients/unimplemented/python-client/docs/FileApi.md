# swagger_client.FileApi

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
```python
from __future__ import print_function
import time
import swagger_client
from swagger_client.rest import ApiException
from pprint import pprint

# create an instance of the API class
api_instance = swagger_client.FileApi()
x_session = 'x_session_example' # str | Session token given at login
filename = 'filename_example' # str | name of the file to delete

try:
    # Deletes a file
    api_instance.delete_file(x_session, filename)
except ApiException as e:
    print("Exception when calling FileApi->delete_file: %s\n" % e)
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **x_session** | **str**| Session token given at login | 
 **filename** | **str**| name of the file to delete | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **get_file_by_name**
> file get_file_by_name(x_session, filename)

download a file

Returns a single file

### Example
```python
from __future__ import print_function
import time
import swagger_client
from swagger_client.rest import ApiException
from pprint import pprint

# create an instance of the API class
api_instance = swagger_client.FileApi()
x_session = 'x_session_example' # str | Session token given at login
filename = 'filename_example' # str | name of the file

try:
    # download a file
    api_response = api_instance.get_file_by_name(x_session, filename)
    pprint(api_response)
except ApiException as e:
    print("Exception when calling FileApi->get_file_by_name: %s\n" % e)
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **x_session** | **str**| Session token given at login | 
 **filename** | **str**| name of the file | 

### Return type

[**file**](file.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **list_user_files**
> list[str] list_user_files(x_session)

List the user's files

### Example
```python
from __future__ import print_function
import time
import swagger_client
from swagger_client.rest import ApiException
from pprint import pprint

# create an instance of the API class
api_instance = swagger_client.FileApi()
x_session = 'x_session_example' # str | Session token given at login

try:
    # List the user's files
    api_response = api_instance.list_user_files(x_session)
    pprint(api_response)
except ApiException as e:
    print("Exception when calling FileApi->list_user_files: %s\n" % e)
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **x_session** | **str**| Session token given at login | 

### Return type

**list[str]**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **upload_file**
> upload_file(x_session, filename, file=file)

uploads a file



### Example
```python
from __future__ import print_function
import time
import swagger_client
from swagger_client.rest import ApiException
from pprint import pprint

# create an instance of the API class
api_instance = swagger_client.FileApi()
x_session = 'x_session_example' # str | Session token given at login
filename = 'filename_example' # str | name of the file
file = '/path/to/file.txt' # file | file to upload (optional)

try:
    # uploads a file
    api_instance.upload_file(x_session, filename, file=file)
except ApiException as e:
    print("Exception when calling FileApi->upload_file: %s\n" % e)
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **x_session** | **str**| Session token given at login | 
 **filename** | **str**| name of the file | 
 **file** | **file**| file to upload | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

