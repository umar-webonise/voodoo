# connection to the database
require 'active_record'
require 'yaml'
connection_settings = YAML.load_file(
  File.expand_path('../database.yml', __FILE__))
begin
  ActiveRecord::Base.establish_connection(connection_settings).connection
rescue
  ActiveRecord::Base.establish_connection(connection_settings.merge(:database => 'postgres'))
  ActiveRecord::Base.connection.create_database(connection_settings[:database])
  ActiveRecord::Base.establish_connection(connection_settings).connection
end
