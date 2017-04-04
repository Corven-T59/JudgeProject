class RemoveExecutions < ActiveRecord::Migration[5.0]
  def change
  	drop_table :executions
  end
end
