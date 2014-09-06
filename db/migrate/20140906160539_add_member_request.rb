class AddMemberRequest < ActiveRecord::Migration
  def up
    add_column :members, :request, :boolean
  end

  def down
    remove_column :members, :request
  end
end
