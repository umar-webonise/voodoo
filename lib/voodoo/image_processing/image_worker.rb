require 'json'
require 'webomagick'
require ::File.expand_path('../../models/job.rb', __FILE__)
# Image Worker class
class ImageWorker
  STORE_PATH = YAML.load_file(
    ::File.expand_path('../../../../config/path.yml', __FILE__))

  def process(message)
    job = parse(message)
    Job.create(job)
    response = Webomagick.image_process(
      job.merge('result' => makepath(job['job_id'], job['source_url'])))
    puts '#########################################################'
    puts "#########{response}"
    puts '#########################################################'
  end

  def parse(message)
    job = JSON.parse(message)
    job['actions'] = eval(job['actions'])
    job
  end

  def makepath(job_id, source_url)
    extension = File.extname(source_url)
    "#{STORE_PATH['jobs_path']}#{job_id}/#{job_id}#{extension}"
  end
end
