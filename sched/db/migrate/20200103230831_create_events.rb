class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :event_name
      t.date :event_start_date
      t.date :event_end_date
      t.time :event_start_time
      t.time :event_end_time
      t.string :event_location
      t.datetime :event_reminder1
      t.datetime :event_reminder2
      t.integer :user_id
      t.integer :category_id #add category with string value
      t.integer :media_id #change to upload_id
      t.integer :notes_id
    end
  end
end
