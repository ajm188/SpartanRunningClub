class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.string :title
      t.text :minutes
      t.date :date
      t.time :time

      t.timestamps
    end
  end
end
