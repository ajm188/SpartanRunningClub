class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
    	t.string :email, :null => false
    	t.string :encrypted_password, :limit => 128, :null => false
      	t.string :confirmation_token, :limit => 128
      	t.string :remember_token, :limit => 128, :null => false

      	t.timestamps
    end

    add_index :members, :email
    add_index :members, :remember_token
  end
end
