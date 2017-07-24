class AddSolutionToCodeforcesSubmition < ActiveRecord::Migration[5.0]
  def change
    add_reference :codeforces_submitions, :solution, foreign_key: true
  end
end
