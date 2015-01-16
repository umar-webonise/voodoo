require 'yaml'
# List of all Accepted formats
module AcceptedFormat
  EXTENSION = YAML.load_file(
    ::File.expand_path('../../../config/accepted_formats.yml', __FILE__))
end
