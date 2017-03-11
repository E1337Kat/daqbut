class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :store_current_location, unless: :devise_controller?
  before_action :store_referrer_id

  protected

  def authenticate_user!
    redirect_to user_reddit_omniauth_authorize_path unless user_signed_in?
  end

  private

  def store_referrer_id
    session[:referrer_id] = params[:referrer].to_i if params[:referrer].present?
  end

  def store_current_location
    store_location_for(:user, request.url)
  end

  def after_sign_out_path_for(resource)
    request.referrer || root_path
  end
end
