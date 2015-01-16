# Rack layer of Voodoo service
require 'rack'
require 'singleton'
require ::File.expand_path('../response.rb', __FILE__)
# Class used to rackup RACK for application
# This class will redirect application as per user application's requested API
# enpoint
# Such as
# 1. Registration for service
# 2. Job request for application
class VoodooService
  include Singleton
  def initialize
    @apps = {}
  end

  def map(route, app)
    @apps[route] = app
  end

  def call(env)
    if @apps[env['REQUEST_PATH']]
      @apps[env['REQUEST_PATH']].call(env)
    else
      response = Response::Response.new
      response.error(404)
    end
  end
end
