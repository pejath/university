# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # rescue_from ActiveRecord::RecordNotFound do
  #   respond_to do |format|
  #     format.html { render file: "#{Rails.root}/public/404.html", layout: false, status: 404 }
  #     format.any { head :not_found }
  #   end
  # end

  protected

  def user_not_authorized
    flash[:alert] = 'У вас недостаточно прав для этого действия'
    redirect_to(request.referrer || root.path)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:email, :password, :invitation_token, :password_confirmation, :role)
    end
  end
end
