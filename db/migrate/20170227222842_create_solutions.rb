class CreateSolutions < ActiveRecord::Migration[5.0]
  def change
    create_table :solutions do |t|
      t.references :user, foreign_key: true, null: false
      t.references :problem, foreign_key: true, null: false
      t.string :solutionFile, null: false
      t.string :language, null: false

      t.timestamps
    end
  end
end
