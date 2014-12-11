namespace :db do
  namespace :test do
    desc "Create test database *(postgres only)"
    task :create => :environment do
      return unless is_local?
      puts "Creating #{db_name} database..."
      system_try_and_fail "createdb #{db_name}"
    end

    desc "Drop test database *(postgres only)"
    task :drop => :environment do
      return unless is_local?
      puts "Droppping #{db_name} database..."
      system_try_and_fail "dropdb #{db_name}"
    end

    desc "Prepare test env database *(postgres only)"
    task :prepare => [:environment, :create, :drop]
  end
end
