require ::File.expand_path('../request.rb', __FILE__)
require ::File.expand_path('../models/user.rb', __FILE__)
require ::File.expand_path('../response.rb', __FILE__)
require ::File.expand_path('../models/job.rb', __FILE__)
# Jobs controller
class Jobs
  def call(env)
    request = Request::JobsRequest.new(env)
    response = Response::JobsResponse.new
    body_hash = request.body_to_hash
    return response.error(400) if request.param_missing?(:jobs, body_hash)
    return response.error(415) unless media_type = request.supported_media?(body_hash)
    return response.error(403) unless user = User.where(api_key: body_hash['api_key'])[0]
    job_id = Job.generate_job_id(user.api_key)
    body_hash.merge!('media_type' => media_type,'job_id' => job_id).delete('api_key')
    job = user.jobs.new(body_hash)
    job.add_to_queue
    response.success(200, job, body_hash)
  end
end
