# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$:.unshift(lib) unless $:.include?(lib)
require 'rake/common_tasks/version'

Gem::Specification.new do |gem|
  gem.name          = 'rake-common_tasks'
  gem.version       = Rake::CommonTasks::VERSION
  gem.authors       = ['Eric Marden']
  gem.email         = ['eric@xentek.net']
  gem.description   = %q{Common Rake Tasks}
  gem.summary       = %q{Common Rake Tasks, serving a variety of needs. Modular! Include only what you want and nothing that you don't.}
  gem.homepage      = 'https://github.com/xentek/rake-common_tasks'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'rake'
  gem.add_dependency 'dotenv'
  gem.add_dependency 'progress_bar'
  gem.add_dependency 'httparty'
  gem.add_dependency 'mime-types'
  gem.add_dependency 'aws-sdk'

  gem.add_development_dependency 'bundler', '~> 1.5'
end
