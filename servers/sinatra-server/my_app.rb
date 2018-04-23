require './lib/swaggering'
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

  def init_db

    if not File.exists? @@configuration.database_path
      # Open a database
      db = SQLite3::Database.new @@configuration.database_path

      # Create a table
      rows = db.execute <<-SQL
        create table users (
          username varchar(20) UNIQUE,
          password_hash char(60),
          session_token varchar(24)
        );
      SQL
    
    end
  end
  
  def MyApp.database
    SQLite3::Database.new @@configuration.database_path
  end
  
end

# include the api files
Dir["./api/*.rb"].each { |file|
  require file
}


