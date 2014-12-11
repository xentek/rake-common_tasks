namespace :tmp do
  desc "Clears the project's tmp directory"
  task :clear do
    puts "Clearing the tmp directory..."
    FileUtils.rm_rf(Dir.glob('tmp/*'))
    puts "Done!"
  end
end
