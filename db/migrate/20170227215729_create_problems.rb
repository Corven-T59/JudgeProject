class CreateProblems < ActiveRecord::Migration[5.0]
  def change
    create_table :problems do |t|
      t.string :name, null: false
      t.string :baseName, null: false
      t.string :color, null: false, default: "000000"
      t.integer :timeLimit, null: false
      t.string :descriptionFile
      t.string :inputFile, null: false
      t.string :outputFile, null: false
      t.string :language, null: false

      t.timestamps
    end
  end
end
