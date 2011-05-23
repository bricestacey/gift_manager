APP_CONFIG = YAML.load_file("#{Rails.root}/config/gift_manager.yml")[Rails.env]

require 'amazon/ecs'

Amazon::Ecs.configure do |options|
  options[:aWS_access_key_id] = APP_CONFIG['amazon']['access_key']
  options[:aWS_secret_key] = APP_CONFIG['amazon']['secret_key']
end
