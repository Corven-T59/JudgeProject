class AddExecutionDataToSolutions < ActiveRecord::Migration[5.0]
  def change
    add_column :solutions, :status, :int
    add_column :solutions, :runtime, :int
  end
end
