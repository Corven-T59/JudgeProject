class AddStaticsToContestsUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :contests_users, :ok, :integer, default: 0, null: false
    add_column :contests_users, :wa, :integer, default: 0, null: false
    add_column :contests_users, :re, :integer, default: 0, null: false
    add_column :contests_users, :tle, :integer, default: 0, null: false
    add_column :contests_users, :ce, :integer, default: 0, null: false
    reversible do |direction|
      direction.up {
        worker = StadisticsWorker.new
        Solution.all.each do |s|
          worker.perform(s.user_id, s.contest_id, s.status)
        end
      }
    end
  end

  def up

  end
end
