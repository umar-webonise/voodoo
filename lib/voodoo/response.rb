require 'yaml'
require 'singleton'
require 'json'
# Module Response
module Response
  RESPONSE = YAML.load_file(
    ::File.expand_path('../../../config/response.yml', __FILE__))
  RESPONSE[:status].default = 'Unknown Status Code'
  # General Response
  class Response
    def success(code, body = {})
      [
        code,
        { 'Content-Type' => RESPONSE[:content_type] },
        [to_content_type(body)]
      ]
    end

    def error(code)
      [
        code,
        { 'Content-Type' => RESPONSE[:content_type] },
        [to_content_type('error' => RESPONSE[:status][code])]
      ]
    end

    def to_content_type(body)
      return body.to_json if RESPONSE[:content_type] == 'application/json'
      return body.to_xml if RESPONSE[:content_type] == 'application/xml'
    end
  end

  # Registration Response
  class RegistrationResponse < Response
    def success(code, user, body = {})
      body.merge!('api_key' => user.api_key)
      super(code, body)
    end
  end

  # Class Jobs Response
  class JobsResponse < Response
    def success(code, job, body = {})
      destination_url = "#{RESPONSE[:destination_url]}#{job.job_id} "
      body.merge!('destination_url' => destination_url)
      super(code, body)
    end
  end
end
