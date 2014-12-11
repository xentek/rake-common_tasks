task :dotenv do
  env_file_suffix = "-#{ENV['RACK_ENV']}" unless is_local?
  env_file = File.join(ENV['RAKE_ROOT'],".env#{env_file_suffix}")
  if File.exist? env_file
    puts "Loading environment from: #{env_file}"
    require 'dotenv'
    Dotenv.load env_file
  end
end

task :environment => :dotenv
