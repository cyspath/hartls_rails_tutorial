if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Configuration for Amazon S3
      :provider              => 'AWS',
      :aws_access_key_id     => ENV['AKIAJEXERWJVYDB3MEYQ'],
      :aws_secret_access_key => ENV['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']
    }
    config.fog_directory     =  ENV['moonwell']
  end
end