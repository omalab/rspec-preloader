require 'pry'
class FileSelector
  GIT_STATUSES_TO_RELOAD = ['M', 'MM', 'A', 'AM', '??']
  IN_FOLDER_MATCHERS = [
    /^app\/.*\.rb$/,
    /^lib\/.*\.rb$/,
    /^spec\/support\/.*\.rb$/,
  ]

  def self.updated_source_files
    new.updated_source_files
  end

  def updated_source_files
    file_statuses_and_paths.select do |file_status_with_paths|
      reload = true
      status, path_in_folder, path_to_load = file_status_with_paths

      # right git status
      reload &&= GIT_STATUSES_TO_RELOAD.include? status
      # path matches what we want reloaded
      reload &&= IN_FOLDER_MATCHERS.inject(false) do |result,matcher|
        result ||= !(path_in_folder =~ matcher).nil?
      end
      puts "Reload: #{path_to_load}" if reload
      reload
    end.map(&:last) # return full path to load
  end

  private

  # [ [ status, path_in_folder, path_to_load] ]
  def file_statuses_and_paths
    statuses_and_names = []
    watched_folders.each do |folder|
      git_status_lines(folder).map do |git_status_line|
        status, path_in_folder = git_status_line.strip.split(' ')
        statuses_and_names << [status, path_in_folder, "#{folder}/#{path_in_folder}"]
      end
    end
    statuses_and_names
  end

  def git_status_lines folder
    git_status(folder).split("\n")
  end

  def git_status folder
    `cd #{folder} && git status --porcelain`
  end

  def config_file_path
    "#{RspecPreloader.root_folder}/.rspec_preloader"
  end

  def watched_folders
    folders = []
    File.readlines(config_file_path).each do |line|
      line = line.strip
      if File.exists? File.expand_path(line)
        folders << File.expand_path(line)
      else
        puts "WARNING!"
        puts "#{config_file_path} defines #{File.expand_path(line)} which does not exist!"
      end
    end if File.exists? "#{RspecPreloader.root_folder}/.rspec_preloader"

    # root folder is last
    folders << RspecPreloader.root_folder
    folders
  end
end
