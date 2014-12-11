require 'aws-sdk'
require 'mime/types'

namespace :s3 do
  namespace :deploy do
    task :staging => :environment do
      if ENV.key?('STAGING_BUCKET')
        deploy_public_to_s3(ENV['STAGING_BUCKET'])
      else
        raise "Set the STAGING_BUCKET environment variable to the name of the bucket you want to deploy to."
      end
    end

    desc "Deploy to S3 (production)"
    task :production => :dotenv do
      if ENV.key?('PRODUCTION_BUCKET')
        deploy_public_to_s3(ENV['PRODUCTION_BUCKET'])
      else
        raise "Set the PRODUCTION_BUCKET environment variable to the name of the bucket you want to deploy to."
      end
    end
  end
  desc "Deploy to S3 (staging)"
  task :deploy => :'deploy:staging'

  def aws_configured?
    !AWS.config.access_key_id.nil? && !AWS.config.secret_access_key.nil?
  end

  def has_aws_env_keys?
    ENV.key?('AWS_ACCESS_KEY_ID') && ENV.key?('AWS_SECRET_ACCESS_KEY')
  end

  def check_aws_config!
    if !aws_configured?
      aws_credentials = AWS::Core::CredentialProviders::SharedCredentialFileProvider.new.get_credentials
    end

    if aws_credentials.empty? && has_aws_env_keys?
      aws_credentials.merge!(access_key_id: ENV['AWS_ACCESS_KEY_ID'], secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'])
    end

    AWS.config(aws_credentials)

    unless aws_configured?
    raise "Deploy Failed: aws-sdk is not configured. More Info: http://docs.aws.amazon.com/AWSSdkDocsRuby/latest/DeveloperGuide/prog-basics-creds.html"
    end
  end

  def deploy_public_to_s3(bucket)
    check_aws_config!
    Dir.glob("public/**/*") do |file|
      unless file == '.' or file == '..'
        unless File.directory?(file)
          filename = file.to_s.gsub('public/', '')
          content_type = MIME::Types.type_for(filename).first
          print " - Writing #{filename} (#{content_type}) to S3"
          AWS::S3.new.buckets[bucket].objects[filename].write(open(file), acl: :public_read, content_type: content_type)
          puts "...Done!"
        end
      end
    end
  end
end
