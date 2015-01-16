require './lib/voodoo/version'
Gem::Specification.new do |s|
  s.name        = 'VooDoo'
  s.version     = Voodoo::VERSION
  s.date        = '2014-12-31'
  s.summary     = 'Media transformation'
  s.description = 'Service for media transformation as per user need limited to image and videos media'
  s.authors     = ['Webonators Nov 2014']
  s.email       = 'www.weboniselab.com'
  s.files       = Dir.glob("{bin,lib}/**/*")
  s.executables << 'voodoo'
  s.require_paths =["lib"]
  s.homepage    =
    'http://rubygems.org/gems/'
  s.license       = 'Webonise Lab'
  s.add_dependency 'activerecord','~> 4.2.0'
  s.add_dependency 'rack','~> 1.6.0'
  s.add_dependency 'pg','~> 0.18.1'
  s.add_dependency 'krakow','~> 0.3.12'
  s.add_dependency 'rmagick','~> 2.13.4'
  s.add_dependency 'streamio-ffmpeg','~> 1.0.0'
end