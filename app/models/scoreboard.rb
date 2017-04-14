class Scoreboard < ApplicationRecord
  self.table_name = 'view_scoreboards'

  def build problem_set

  end

  protected
  # The report_state_popularities relation is a SQL view,
  # so there is no need to try to edit its records ever.
  # Doing otherwise, will result in an exception being thrown
  # by the database connection.
  def readonly?
    true
  end
end
