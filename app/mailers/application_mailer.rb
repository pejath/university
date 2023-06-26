# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'no_reply@your_university.com'
  layout 'mailer'
end
