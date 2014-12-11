desc "Start a local server with public as it's root"
task :server => :environment do
  ENV['PORT'] ||= '8080'
  puts "Started site on localhost:#{ENV['PORT']}... (CTRL-C to stop)"
  `pushd public; python -m SimpleHTTPServer #{ENV['PORT']}`
end
