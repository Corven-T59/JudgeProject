class FixScoreboardView < ActiveRecord::Migration[5.0]
  def up
    self.connection.execute %Q(
CREATE OR REPLACE VIEW view_scoreboards AS
SELECT
  contest_id,
  users.id as user_id,
  users.email,solutions.problem_id,
  SUM(DISTINCT solutions.status = 4) as correct,
  SUM(solutions.status <> 4) as inconrrect,
  MAX(solutions.created_at) as sent_time
FROM
  solutions
  INNER JOIN
    `users` ON `users`.`id` = `solutions`.`user_id`
GROUP BY
  problem_id, user_id, contest_id;)
  end

  def down
    self.connection.execute %Q(
CREATE OR REPLACE VIEW view_scoreboards AS
SELECT
  contest_id,
  users.id as user_id,
  users.email,solutions.problem_id,
  SUM(DISTINCT solutions.status = 4) as correct,
  SUM(solutions.status <> 4) as inconrrect,
  MAX(solutions.created_at) as sent_time
FROM
  solutions
  INNER JOIN
    `users` ON `users`.`id` = `solutions`.`user_id`
WHERE
  contest_id = 1
GROUP BY
  problem_id, user_id;
                            )
  end
end
