class ChangePracticeTimes < ActiveRecord::Migration
  def up
    add_column :practices, :time, :time
    Practice.all.each do |practice|
      practice.time = practice.date.to_time
      practice.save
    end
    remove_column :practices, :date
  end

  def down
    add_column :practices, :date, :datetime
    Practice.all.each do |practice|
      practice.date = practice.time
      practice.save
    end
    remove_column :practices, :time
  end
end
