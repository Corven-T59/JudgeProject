class AddExecutionDataToSolutions < ActiveRecord::Migration[5.0]
  def change
    add_column :solutions, :status, :int, null: false
    add_column :solutions, :runtime, :int, null: false
  end
end
