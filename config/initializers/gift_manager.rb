APP_CONFIG = YAML.load_file("#{Rails.root}/config/gift_manager.yml")[Rails.env]

require 'amazon/ecs'

Amazon::Ecs.configure do |options|
  options[:associate_tag] = APP_CONFIG['amazon']['associate_tag']
  options[:AWS_access_key_id] = APP_CONFIG['amazon']['access_key']
  options[:AWS_secret_key] = APP_CONFIG['amazon']['secret_key']
end
