class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def reddit
    @user = User.from_omniauth(request.env['omniauth.auth'])
    referrer = User.where(id: session[:referrer_id]).first if session[:referrer_id]
    @user.referrer ||= referrer if referrer.present?

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Reddit') if is_navigational_format?
    else
      session['devise.reddit_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
