# Rake::CommonTasks

Common Rake Tasks that are suitable for multiple projects.

## Installation

Add this line to your application's Gemfile:

    gem 'rake-common_tasks', require: 'rake/common_tasks'

And then execute:

    $ bundle

## Usage

Sample Rakefile:

````rake
#!/usr/bin/env rake

# environment
ENV['RACK_ENV'] ||= 'development'

# load path
lib_path = File.expand_path('../lib', __FILE__)
($:.unshift lib_path) unless ($:.include? lib_path)

require 'rake'
require 'rake/common_taks'

# mixin helper methods used when writing rake tasks,
# e.g. system_try_and_fail, is_local?, progress_bar...
include Rake::CommonTasks::Helpers

# import all common rake tasks -- not recommended
CommonRakeTasks.import!

# import a specific set of rake tasks
CommonRakeTasks.import! 'default.rake', 'dotenv.rake' # etc...
````

## Available Rake Tasks

````bash
# db.rake
rake db:test:create     # Create test env database *(postgres only)
rake db:test:drop       # Drop test env database *(postgres only)
rake db:test:reset      # Drop and Create test env database *(postgres only)

# dotenv.rake
rake dotenv             # Load environment settings from .env

# default.rake
rake                    # Run tests
rake test               # Run tests

# s3deploy.rake
rake s3:deploy             # deploy to S3 (Staging)
rake s3:deploy:staging     # deploy to S3 (Staging)
rake s3:deploy:production  # deploy to S3 (production)

# server.rake
rake server             # Start a local server with `./public' as it's root

# tmp.rake
rake tmp:clear          # Clears the project's tmp directory
````
