class AddFieldsToSolutions < ActiveRecord::Migration[5.0]
  def change
    add_column :solutions, :input, :text, null: true, default: nil
    add_column :solutions, :output, :text, null: true, default: nil
    add_column :solutions, :user_output, :text, null: true, default: nil
  end
end
