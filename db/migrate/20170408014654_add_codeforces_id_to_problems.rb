class AddCodeforcesIdToProblems < ActiveRecord::Migration[5.0]
  def change
    add_column :problems, :codeforces_contest_id, :int
    add_column :problems, :codeforces_index, :string
  end
end
