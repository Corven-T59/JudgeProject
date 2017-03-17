class CreateContestsUsers < ActiveRecord::Migration[5.0]
  def change  	 
    create_table :contests_users, id: false do |t|
    	t.belongs_to :contest, null: false
    	t.belongs_to :user, null: false
    end
    add_index :contests_users, ["contest_id", "user_id"], :unique => true
  end
end
