class ChangeEventsDateAndTime < ActiveRecord::Migration
  def up
    add_column :events, :date, :date
    Event.all.each do |event|
      event.date = event.time.to_date
      event.save
    end
    change_column :events, :time, :time
  end

  def down
    change_column :events, :time, :datetime
    remove_column :events, :date
  end
end
