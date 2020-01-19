class ChangeReminderFromTimeToInteger < ActiveRecord::Migration
  def change
    remove_column :events, :event_reminder1, :time
    remove_column :events, :event_reminder2, :time
    add_column :events, :event_reminder1, :integer
    add_column :events, :event_reminder2, :integer
  end
end
