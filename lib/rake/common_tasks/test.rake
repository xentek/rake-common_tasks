namespace :db do
  namespace :test do
    desc "Create test env database *(postgres only)"
    task :create => :environment do
      return unless is_local?
      puts "Creating #{db_name} database..."
      system_try_and_fail "createdb #{db_name}"
    end

    desc "Drop test env database *(postgres only)"
    task :drop => :environment do
      return unless is_local?
      puts "Droppping #{db_name} database..."
      system_try_and_fail "dropdb #{db_name}"
    end

    desc "Drop and Create test env database *(postgres only)"
    task :reset => [:environment, :create, :drop]
  end
end
