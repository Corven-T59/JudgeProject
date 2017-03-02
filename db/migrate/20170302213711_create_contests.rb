class CreateContests < ActiveRecord::Migration[5.0]
  def change
    create_table :contests do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :difficulty, null: false
      t.datetime :startDate, null: false
      t.datetime :endDate, null: false

      t.timestamps
    end
  end
end
