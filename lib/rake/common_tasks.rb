require 'progress_bar'
require "rake/common_tasks/version"

module Rake
  module CommonTasks
    def self.import!(*files)
      ENV['RAKE_ROOT'] = Dir.pwd
      tasks = Dir.glob(File.expand_path('../common_tasks/**/*.rake', __FILE__))
      tasks.each do |task|
        if files.empty?
          ::Rake.load_rakefile task
        end

        if !files.empty? && files.include?(Pathname.new(task).basename.to_s)
          ::Rake.load_rakefile task
        end
      end
    end

    module Helpers
      def system_try_and_fail(command)
        sh command do |ok, res|
          if !ok
            yield if block_given?
            raise "COMMAND FAILED: Error running #{command} (Pwd: #{Dir.pwd}, exit status:#{res.exitstatus}). Aborting"
          end
        end
      end

      def check_env!
        raise "RACK_ENV unknown" if ENV['RACK_ENV'].nil? || ENV['RACK_ENV'] == ''
      end

      def is_local?
        check_env!
        %w(development test).include? ENV['RACK_ENV']
      end

      def is_production?
        check_env!
        ENV['RACK_ENV'] == 'production'
      end

      def progress_bar(total = 0)
        ::ProgressBar.new(total, :bar, :counter, :rate)
      end

      def test_db_name
        if ENV['DATABASE_NAME'].nil? or ENV['DATABASE_NAME'] == ''
          raise "ENV['DATABASE_NAME'] is nil or blank!"
        end

        "#{ENV['DATABASE_NAME']}_test"
      end
    end
  end
end
