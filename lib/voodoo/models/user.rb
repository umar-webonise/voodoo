require 'digest'
require 'active_record'
require ::File.expand_path('../../../../config/connection.rb', __FILE__)
# Voodoo Client model
class User < ActiveRecord::Base
  has_many :jobs, dependent: :destroy
  before_create do
    self.api_key = generate_api_key(app_domain)
  end

  def generate_api_key(application_domain)
    user_config = YAML.load_file(File.expand_path('../../../../config/user.yml', __FILE__))
    Digest::SHA256.hexdigest("#{application_domain} #{Time.now}\
              #{rand(123_456_78)}")[0, user_config['api_key_length']]
  end
end
