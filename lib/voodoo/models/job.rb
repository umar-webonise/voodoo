require 'digest'
require 'yaml'
require 'json'
require 'active_record'
require ::File.expand_path('../../../../config/connection.rb', __FILE__)
require ::File.expand_path('../../producers.rb', __FILE__)
# Jobs model
class Job < ActiveRecord::Base
  belongs_to :user

  def self.generate_job_id(api_key)
    job_config = YAML.load_file(
      File.expand_path('../../../../config/job.yml', __FILE__))
    Digest::SHA256.hexdigest(
      "#{api_key}#{Time.now.strftime('%s')}\
      #{rand(123_456_78)}")[0, job_config['job_id_length']]
  end

  def add_to_queue
    attr_hash = attributes
    attr_hash.select! { |key, _value| attr_hash[key] }
    attr_json = attr_hash.to_json
    producer = Producer::TYPE[media_type]
    producer.write(attr_json)
  end
end
