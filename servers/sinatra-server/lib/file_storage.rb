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
    
  def write_file(username, filename, content)
    error = nil
    
    begin
      parent_dir = user_root(username)
      
      if not Dir.exists?(parent_dir)
        FileUtils.mkdir_p(parent_dir)
        FileUtils.chmod(0700, parent_dir)
      end
      
      fullpath = File.join(parent_dir, filename)
      
      File.open(fullpath, "w") do |f|
        f.write(content)
      end
      FileUtils.chmod(0700, fullpath)
      
    rescue => e
      return e.to_s
    end
    
    return nil
  end
  
  def read_file(username, filename)
    parent_dir = user_root(username)
    
    if not Dir.exists?(parent_dir)
      return nil, "User has no files"
    end
    
    fullpath = File.join(parent_dir, filename)
    
    if not File.exists?(fullpath)
      return nil, "File does not exist"
    end
    
    content = File.read(fullpath)
    
    return content, nil
  end
  
end