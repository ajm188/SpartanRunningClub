class DropMeetings < ActiveRecord::Migration
  def up
    drop_table :members_meetings
    drop_table :meetings
  end

  def down
    create_table :meetings do |t|
      t.string :title
      t.text :minutes
      t.date :date
      t.time :time

      t.timestamps
    end
    create_table :members_meetings do |t|
      t.integer :member_id
      t.integer :meeting_id
      t.string :relationship

      t.timestamps
    end
    add_index :members_meetings, [:member_id, :meeting_id, :relationship],
      unique: true, name: :members_meetings_index
  end
end
