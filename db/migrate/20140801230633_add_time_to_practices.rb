class AddTimeToPractices < ActiveRecord::Migration
  def up
    add_column :practices, :date, :datetime

    Practice.transaction do
      Practice.all.each do |practice|
        practice.update_attributes({
          date: DateTime.strptime("#{practice.day} #{practice.hour}:#{practice.minute} #{practice.am_pm}", '%A %l:%M %p')
        })
      end
    end

    remove_column :practices, :hour
    remove_column :practices, :minute
    remove_column :practices, :am_pm
  end

  def down
    add_column :practices, :hour, :string
    add_column :practices, :minute, :string
    add_column :practices, :am_pm, :string

    Practice.transaction do
      Practice.all.each do |practice|
        hour = practice.date.hour > 12 ? practice.date.hour - 12 : practice.date.hour
        practice.update_attributes({
          hour: hour.to_s,
          minute: practice.date.min.to_s,
          am_pm: hour == practice.date.hour ? 'AM' : 'PM'
        })
      end
    end

    remove_column :practices, :date
  end
end
