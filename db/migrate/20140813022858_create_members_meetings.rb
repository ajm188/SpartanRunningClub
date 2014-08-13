class CreateMembersMeetings < ActiveRecord::Migration
  def up
    create_table :members_meetings do |t|
      t.integer :member_id
      t.integer :meeting_id
      t.string :relationship

      t.timestamps
    end
    add_index :members_meetings, [:member_id, :meeting_id, :relationship],
      unique: true, name: :members_meetings_index
  end

  def down
    drop_table :members_meetings
  end
end
