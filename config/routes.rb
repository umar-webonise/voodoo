require ::File.expand_path('../../lib/voodoo/voodoo_service.rb', __FILE__)
require ::File.expand_path('../../lib/voodoo/registration.rb', __FILE__)
require ::File.expand_path('../../lib/voodoo/jobs.rb', __FILE__)
app = VoodooService.instance
app.map('/v1/registration', Registration.new)
app.map('/v1/create/job', Jobs.new)
