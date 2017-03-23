class UpdateSolutionsAddReferenceToContest < ActiveRecord::Migration[5.0]
  def change
  	add_reference :solutions, :contest, index: true
  	add_foreign_key :solutions, :contests
  end
end
