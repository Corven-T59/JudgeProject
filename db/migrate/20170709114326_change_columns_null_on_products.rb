class ChangeColumnsNullOnProducts < ActiveRecord::Migration[5.1]
  def up
    change_column :problems, :timeLimit, :integer, :null => true
    change_column :problems, :inputFile, :string, :null => true
    change_column :problems, :outputFile, :string, :null => true
  end

  def down
    change_column :problems, :timeLimit, :integer, :null => false
    change_column :problems, :inputFile, :string, :null => false
    change_column :problems, :outputFile, :string, :null => false
  end
end
