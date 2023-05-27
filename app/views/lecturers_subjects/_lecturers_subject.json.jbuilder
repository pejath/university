# frozen_string_literal: true

json.extract! lecturers_subject, :id, :created_at, :updated_at
json.url lecturers_subject_url(lecturers_subject, format: :json)
