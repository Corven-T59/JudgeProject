class AddDisabledToProblems < ActiveRecord::Migration[5.0]
  def change
    add_column :problems, :disabled, :boolean, default: false
  end
end
