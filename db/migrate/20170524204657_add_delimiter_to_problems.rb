class AddDelimiterToProblems < ActiveRecord::Migration[5.0]
  def change
    add_column :problems, :delimiter, :string, default: ""
  end
end
