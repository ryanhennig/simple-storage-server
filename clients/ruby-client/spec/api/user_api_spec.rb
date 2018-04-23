=begin
#Simple Storage Server

#A Simple Storage Server API

OpenAPI spec version: 1.0.0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 2.3.1

=end

require 'spec_helper'
require 'json'


# Unit tests for SwaggerClient::UserApi
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'UserApi' do
  before do
    # run before each test
    @instance = SwaggerClient::UserApi.new
    # @instance.api_client.config.debugging = true
    
    @valid_username = "username"
    @valid_password = "password"

    @valid_user = {
      "username": @valid_username,
      "password": @valid_password
    }

  end

  after do
    # run after each test
  end

  describe 'test an instance of UserApi' do
    it 'should create an instance of UserApi' do
      expect(@instance).to be_instance_of(SwaggerClient::UserApi)
    end
  end

  # unit tests for create_user
  # Create a new user
  # 
  # @param body user object to create
  # @param [Hash] opts the optional parameters
  # @return [nil]
  describe 'create_user test' do
    it "should not allow usernames less than length 3" do
      user = {
        "username": "a",
        "password": @valid_password
      }
            
      create_user_failure(user, "Invalid username")  
    end
    
    it "should not allow usernames greater than length 20" do
      len21 = "abcdefghijklmnopqrstu"
      expect(len21.length).to eq(21)
      user = {
        "username": len21,
        "password": @valid_password
      }
            
      create_user_failure(user, "Invalid username")        
    end
    
    it "should not allow user to be registered twice" do      
      create_user_successfully(@valid_user) 
      create_user_failure(@valid_user, "User already exists")                  
    end
  
    it "should allow usernames of length 4" do
      user = {
        "username": "abcd",
        "password": @valid_password
      }
      
      create_user_successfully(user)      
    end
    
    it "should allow usernames of length 20" do      
      len20 = "abcdefghijklmnopqrst"
      expect(len20.length).to eq(20)
      user = {
        "username": len20,
        "password": @valid_password
      }
      
      create_user_successfully(user)      
    end
    
    it "should allow passwords of length 8" do
      len8 = "abcdefgh"
      expect(len8.length).to eq(8)
      user = {
        "username": "abcd",
        "password": @valid_password
      }
      
      create_user_successfully(user)      
    end
    
    
    it "should not allow passwords less than length 8" do
      len7 = "abcdefg"
      expect(len7.length).to eq(7)
      user = {
        "username": @valid_username,
        "password": len7
      }
      
      create_user_failure(user, "Invalid password")            
    end
        

    
  end

  # unit tests for login_user
  # Logs user into the system
  # 
  # @param body user object to create
  # @param [Hash] opts the optional parameters
  # @return [SessionToken]
  describe 'login_user' do
    it "should work" do
      @instance.api_client.config.debugging = true
      create_user_successfully(@valid_user)
      login_user_successfully(@valid_user)
    end
    
    it "should not accept invalid password" do
      @instance.api_client.config.debugging = false
      create_user_successfully(@valid_user)
      
      wrong_pass = {
        username: @valid_username,
        password: "wrong_password"
      }
      login_user_failure(wrong_pass, "Invalid password")
    end
  end
  
  def create_user_successfully(user)
    begin
      @instance.delete_user(user)
      data, status_code, headers = @instance.create_user_with_http_info(user.to_json)
    rescue SwaggerClient::ApiError => ae
      output = {
        "code": ae.code,
        "response": ae.response_body
      }
      expect(output).to be_nil
    end
  
    expect(status_code).to eq(204)
    expect(data).to be_nil
  
    return data, status_code, headers
  end
  
  def create_user_failure(user, error)
    begin
      data, status_code, headers = @instance.create_user_with_http_info(user.to_json)
      fail "no error was thrown"
    rescue SwaggerClient::ApiError => ae
      expect(ae.code).to eq(400) 
      expect(ae.response_body).to eq({ error: error}.to_json)
      h = ae.response_headers
      expect(h["Content-Type"]).to eql("application/json")
    end
  end
  
  def login_user_successfully(user)
    begin
      data, status_code, headers = @instance.login_user_with_http_info(user.to_json)
    rescue SwaggerClient::ApiError => ae
      output = {
        "code": ae.code,
        "response": ae.response_body
      }
      expect(output).to be_nil
    end
  
    expect(status_code).to eq(200)
  
    expect(data.token).to be_truthy
  
    return data, status_code, headers
  end
  
  def login_user_failure(user, error)
    begin
      data, status_code, headers = @instance.login_user_with_http_info(user.to_json)
      fail "no error was thrown"
    rescue SwaggerClient::ApiError => ae
      expect(ae.code).to eq(403) 
      expect(ae.response_body).to eq({ error: error}.to_json)
      h = ae.response_headers
      expect(h["Content-Type"]).to eql("application/json")
    end
  end

end
