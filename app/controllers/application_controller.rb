class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate_user!
    redirect_to user_reddit_omniauth_authorize_path unless user_signed_in?
  end
end
