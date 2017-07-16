class AddAutoIncrementIdContestUser < ActiveRecord::Migration[5.1]
  def change
    reversible do |direction|
      direction.up {
        execute("ALTER TABLE contests_users MODIFY COLUMN id int(11) auto_increment;")
      }
    end
  end
end
