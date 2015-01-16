# File creates to types of producers
require 'krakow'
require 'yaml'
# Module contains all the Producers for the Queue
module Producer
  CONFIG = YAML.load_file(
        ::File.expand_path('../../../config/producers.yml', __FILE__))
  TYPE = {
    'image' => Krakow::Producer.new(CONFIG[:image_producer]),
    'video' => Krakow::Producer.new(CONFIG[:video_producer])
  }
end
