class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :media_type
      t.string :entry
      t.text :comments
      t.integer :user_id
      t.integer :category_id
      t.integer :event_id
    end
  end
end
