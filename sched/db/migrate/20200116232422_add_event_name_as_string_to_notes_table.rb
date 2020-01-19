class AddEventNameAsStringToNotesTable < ActiveRecord::Migration
  def change
    add_column :notes, :event_name, :string
  end
end
