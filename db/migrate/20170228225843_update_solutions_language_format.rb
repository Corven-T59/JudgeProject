class UpdateSolutionsLanguageFormat < ActiveRecord::Migration[5.0]
  def up
    change_column :solutions, :language, :integer
  end

  def down
    change_column :solutions, :language, :string
  end
end
