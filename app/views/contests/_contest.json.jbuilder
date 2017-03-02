json.extract! contest, :id, :title, :description, :difficulty, :startDate, :endDate, :created_at, :updated_at
json.url contest_url(contest, format: :json)
