APP_CONFIG = YAML.load_file("#{Rails.root}/config/gift_manager.yml")[Rails.env]

class GiftManagerRailtie < Rails::Railtie

  initializer "gift_manager.initialize_aws" do |app|
    require 'amazon/ecs'

    Amazon::Ecs.configure do |options|
      options[:aWS_access_key_id] = APP_CONFIG['amazon']['access_key']
      options[:aWS_secret_key] = APP_CONFIG['amazon']['secret_key']
    end
  end

  initializer "gift_manager.initialize_voyager" do |app|
     if app.config.enable_voyager
       require File.join(Rails.root, 'lib', 'voyager.rb')

       # Establish Voyager database connection. Options stored in `config/gift_manager_voyager.yml`
       voyager_config = YAML::load(File.open(File.join(Rails.root, 'config', 'gift_manager_voyager.yml')))[Rails.env]
       Voyager::AR::Base.establish_connection(voyager_config)

       # Register the observer.
       # See 'Loading' header at http://api.rubyonrails.org/classes/ActiveRecord/Observer.html
       Voyager::BookObserver.instance
     end
   end
end
