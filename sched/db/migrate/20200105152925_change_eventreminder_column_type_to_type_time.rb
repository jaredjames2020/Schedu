class ChangeEventreminderColumnTypeToTypeTime < ActiveRecord::Migration
  def change
    change_column :events, :event_reminder1, :time
    change_column :events, :event_reminder2, :time
  end
end
