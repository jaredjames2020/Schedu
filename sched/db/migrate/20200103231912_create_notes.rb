class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :entry
      t.integer :user_id
      t.integer :event_id
      t.integer :category_id
    end
  end
end
