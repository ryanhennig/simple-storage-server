module UserHelpers
  
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
  
    return data.token
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

RSpec.configure do |c|
  c.include UserHelpers
end