require ::File.expand_path('../request.rb', __FILE__)
require ::File.expand_path('../models/user.rb', __FILE__)
require ::File.expand_path('../response.rb', __FILE__)
# Registration
class Registration
  def call(env)
    request = Request::RegistrationRequest.new(env)
    response = Response::RegistrationResponse.new
    body_hash = request.body_to_hash
    return response.error(400) if request.param_missing?(:registration, body_hash)
    return response.error(403) if User.exists?(app_domain: body_hash['app_domain'])
    user = User.create(app_domain: body_hash['app_domain'])
    response.success(200, user, body_hash)
  end
end
