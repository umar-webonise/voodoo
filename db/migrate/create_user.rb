# Create User Migration
class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |u|
      u.string :app_domain
      u.string :api_key

      u.timestamps null: false
    end
  end
end
