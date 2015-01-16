#!/usr/bin/env ruby
require './config/connection'
require './db/migrate/create_user'
require './db/migrate/create_job'
require './lib/voodoo/models/job'
require './lib/voodoo/models/user'
CreateUser.migrate(:change)
CreateJob.migrate(:change)
