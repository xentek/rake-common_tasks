require 'dalli'

namespace :memcache do
  desc "Flush all data in memcached"
  task :flush_all => :environment do
    puts "Flushing All data stored in memcached..."
    Dalli::Client.new.flush_all
    puts "Done!"
  end
end
task :'memcached:flush_all' => [:'memcache:flush_all']
