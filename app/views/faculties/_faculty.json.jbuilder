# frozen_string_literal: true

json.extract! faculty, :id, :created_at, :updated_at
json.url faculty_url(faculty, format: :json)
