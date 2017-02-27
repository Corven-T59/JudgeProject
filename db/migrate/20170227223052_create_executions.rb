class CreateExecutions < ActiveRecord::Migration[5.0]
  def change
    create_table :executions do |t|
      t.references :solution, foreign_key: true, null: false
      t.string :status, null: false
      t.integer :runTime, null: false

      t.timestamps
    end
  end
end
