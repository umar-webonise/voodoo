require 'yaml'
require 'json'
require 'rack'
require 'uri'
require ::File.expand_path('../accepted_format.rb', __FILE__)
# Dispatcher
module Request
  REQUEST = YAML.load_file(
    ::File.expand_path('../../../config/request.yml', __FILE__))

  # Class Request
  class Request < Rack::Request
    def body_to_hash
      req_body = body.read
      return JSON.parse(req_body) if REQUEST[:content_type] == 'application/json'
      return XML.parse(req_body) if REQUEST[:content_type] == 'application/xml'
    end

    def param_missing?(request_type, body_hash)
      request_contents = REQUEST[request_type]
      body_hash.each do |key, _value|
        return true unless request_contents.include?(key)
      end
      false
    end
  end

  # Class Registration Request
  class RegistrationRequest < Request
  end

  # Class Jobs Request
  class JobsRequest < Request
    def supported_media?(body_hash)
      uri = URI(body_hash['source_url'])
      AcceptedFormat::EXTENSION[File.extname(uri.path).downcase]
    end
  end
end
