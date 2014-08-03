class CreateFollowings < ActiveRecord::Migration
  def up
    create_table :followings do |t|
      t.integer :member_id
      t.integer :followable_id
      t.integer :followable_type

      t.timestamps
    end

    add_index :followings, [:followable_id, :followable_type]
  end

  def down
    drop_table :followings
  end
end
