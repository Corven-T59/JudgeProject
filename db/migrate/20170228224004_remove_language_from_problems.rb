class RemoveLanguageFromProblems < ActiveRecord::Migration[5.0]
  def change
    remove_column :problems, :language, :string
  end
end
