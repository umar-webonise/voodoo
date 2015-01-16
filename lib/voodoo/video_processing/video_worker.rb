# Video worker
require 'videoconverter'
require 'yaml'
require 'json'
require ::File.expand_path('../../models/job.rb', __FILE__)
class VideoWorker
    STORE_PATH = YAML.load_file(
      ::File.expand_path('../../../../config/path.yml', __FILE__))

   def process(message)
    job = parse(message)
    Job.create(job)
    options = {
      "source_url" => job['source_url'],
      "actions" => job['actions'],
      "dir" => make_path(job['job_id'])
    }
    response = VideoConverter.process(options)

    puts '################################################################'
    puts "##########################{response}"
    puts '###############################################################'
  end

  def parse(message)
    job = JSON.parse(message)
    job['actions'] = eval(job['actions'])
    job
  end

  def make_path(job_id)
    "#{STORE_PATH['jobs_path']}#{job_id}"
  end
end
