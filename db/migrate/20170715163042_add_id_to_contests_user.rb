class AddIdToContestsUser < ActiveRecord::Migration[5.1]
  def change
    add_column :contests_users, :id, :primary_key
    reversible do |direction|
      direction.up {
        execute("ALTER TABLE contests_users MODIFY id INTEGER first;")
      }
    end
  end
end
