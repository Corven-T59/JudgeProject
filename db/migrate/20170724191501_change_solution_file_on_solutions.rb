class ChangeSolutionFileOnSolutions < ActiveRecord::Migration[5.1]
  def up
    change_column :solutions, :solutionFile, :string, :null => true
  end

  def down
    change_column :solutions, :solutionFile, :string, :null => false
  end
end
