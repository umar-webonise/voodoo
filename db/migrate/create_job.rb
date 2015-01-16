# Create Job Migration
class CreateJob < ActiveRecord::Migration
  def change
    create_table :jobs do |j|
      j.integer :user_id
      j.string :job_id
      j.string :media_type
      j.string :actions
      j.string :source_url
      j.string :notification_url
      j.string :original_media
      j.string :processed_media
      j.string :status

      j.timestamps null: false
    end
  end
end
