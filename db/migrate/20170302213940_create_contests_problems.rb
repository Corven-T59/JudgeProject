class CreateContestsProblems < ActiveRecord::Migration[5.0]
  def change
    create_table :contests_problems, id: false do |t|
    	t.belongs_to :contest, index: true, null: false
    	t.belongs_to :problem, index: true, null: false
    end
  end
end
