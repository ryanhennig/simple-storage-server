require "fileutils"

class FileStorage
  
  attr_reader :storage_root
  
  def initialize(storage_root)
    if not storage_root
      raise "No storage root given"
    end
    
    @storage_root = storage_root
    
    if not Dir.exists?(@storage_root)
      FileUtils.mkdir_p(@storage_root)
    end
    
    FileUtils.chmod(0700, @storage_root)
  end
  
  def user_root(username)
    File.join(@storage_root, username)
  end
  
  def get_filenames(username)
    []
  end
    
  def FileStorage.write_file(username, filename, content)
    error = nil
    
    return error
  end
  
end