class CreatePractices < ActiveRecord::Migration
  def change
    create_table :practices do |t|
      t.string :day, null: false
      t.string :hour
      t.string :minute
      t.string :am_pm, null: false

      t.timestamps
    end
  end
end
