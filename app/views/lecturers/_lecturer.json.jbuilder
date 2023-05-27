# frozen_string_literal: true

json.extract! lecturer, :id, :created_at, :updated_at
json.url lecturer_url(lecturer, format: :json)
