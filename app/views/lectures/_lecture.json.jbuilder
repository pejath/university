# frozen_string_literal: true

json.extract! lecture, :id, :created_at, :updated_at
json.url group_lectures_path(lecture, format: :json)
