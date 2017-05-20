class AddDefaultStatusToSolutions < ActiveRecord::Migration[5.0]
  def up
    change_column_default :solutions, :status, 0
    change_column_null :solutions, :runtime, true
  end

  def down
    change_column_default :solutions, :status, nil
    change_column_null :solutions, :runtime, false
  end
end
