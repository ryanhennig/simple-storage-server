require './lib/swaggering'
require './lib/file_storage'
require "sqlite3"
        
# only need to extend if you want special configuration!
class MyApp < Swaggering
  self.configure do |config|
    config.api_version = '1.0.0' 
  end
  
  def initialize
    super
    init_db
  end
  
  helpers do
    def request_headers
      env.inject({}){|acc, (k,v)| acc[$1.downcase] = v if k =~ /^http_(.*)/i; acc}
    end  
    
    def get_session_token
      req = request_headers

      if not req.include? "x_session"
        return nil, "x_session parameter missing"
      end
  
      token = req["x_session"].to_s
      if not token
        return nil, "token value missing"
      end
      
      return token, nil
    end
    
    def get_user_from_session
      token, error = get_session_token
      if error
        return nil, error
      end
      
      db = MyApp.database

      # This doesn't work for some reason, so the workaround is to use interpolation and
      # use a character whitelist to prevent SQL injection.
      # results = db.execute("SELECT username FROM users WHERE session_token = ? ", [token])

      if not /^[a-f0-9]+$/ === token
        return nil, "session token #{token} is invalid."    
      end

      results = db.execute("SELECT username FROM users WHERE session_token = '#{token}' ")
      if results.length == 0
        return nil, "session token #{token} not found."
      end

      username = results[0][0]

      if not username
        return nil, "user not found in database"
      end
      
      return username, nil
    end
  end

  def init_db

    if not File.exists? @@configuration.database_path
      # Open a database
      db = SQLite3::Database.new @@configuration.database_path

      # Create a table
      rows = db.execute <<-SQL
        create table users (
          username varchar(20) UNIQUE,
          password_hash char(60),
          session_token varchar(32) UNIQUE
        );
      SQL
    
    end
  end
  
  def MyApp.database
    @@database ||= SQLite3::Database.new @@configuration.database_path
  end
  
end

# include the api files
Dir["./api/*.rb"].each { |file|
  require file
}


