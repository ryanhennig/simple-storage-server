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
    begin
      parent_dir = user_root(username)
    
      if not Dir.exists?(parent_dir)
        return []
      end
    
      return Dir.entries(parent_dir).select {|f| !File.directory? f}
      
    rescue => e
      return nil, e.to_s
    end
  end
    
  def write_file(username, filename, content)    
    begin
      parent_dir = user_root(username)
      
      if not Dir.exists?(parent_dir)
        FileUtils.mkdir_p(parent_dir)
        FileUtils.chmod(0700, parent_dir)
      end
      
      fullpath = File.join(parent_dir, filename)
      
      #Extra security check to be paranoid
      if not fullpath.start_with?(parent_dir)
        return "File not found"
      end
      
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
    begin
      parent_dir = user_root(username)
    
      if not Dir.exists?(parent_dir)
        return nil, "User has no files"
      end
    
      fullpath = File.join(parent_dir, filename)
    
      #Extra security check to be paranoid
      if not fullpath.start_with?(parent_dir)
        return nil, "File not found"
      end
    
      if not File.exists?(fullpath)
        return nil, "File does not exist"
      end
    
      content = File.read(fullpath)
      return content, nil
    rescue => e
      return nil, e.to_s
    end
  end
  
  def delete_file(username, filename)
    parent_dir = user_root(username)
    
    if not Dir.exists?(parent_dir)
      return "User has no files"
    end
    
    fullpath = File.join(parent_dir, filename)
    
    #Extra security check to be paranoid
    if not fullpath.start_with?(parent_dir)
      return "File not found"
    end
    
    if not File.exists?(fullpath)
      return "File does not exist"
    end
    
    File.delete(fullpath)
    
    return nil
  end
  
  def delete_all_files(username)
    parent_dir = user_root(username)
    
    if not Dir.exists?(parent_dir)
      return
    end
    
    FileUtils.rm_r parent_dir
  end
  
end