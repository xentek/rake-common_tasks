namespace :redis do
  desc "Flush data from Redis db"
  task :flushdb => :environment do
    db = URI.parse(ENV['REDIS_URL']).try(:path).to_s[1..-1].to_i
    puts "Flushing data from Redis db: #{db}..."
    Redis.new.flushdb
    puts "Done!"
  end

  desc "Flush all data from Redis"
  task :flushall => :environment do
    server = "localhost:6379/0"
    if ENV['REDIS_URL']
      uri = URI.parse(ENV['REDIS_URL'])
      server = "#{uri.host}:#{uri.port}#{uri.path}"
    end
    puts "Flushing all data from #{server}..."
    Redis.new.flushall
    puts "Done!"
  end
end
