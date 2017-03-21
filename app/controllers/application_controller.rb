class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :store_referrer_id
  before_action :track_pageview

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

  def track_pageview
    return if request.local?
    Keen.publish_async 'pageviews', {
      url: request.original_url,
      ip_address: request.remote_ip,
      user_agent: request.user_agent,
      referrer: {
        url: request.referrer
      },
      keen: {
        timestamp: Time.now.iso8601,
        addons: [
          {
            name: 'keen:ip_to_geo',
            input: { ip: 'ip_address' },
            output: 'geo_info'
          },
          {
            name: 'keen:url_parser',
            input: { url: 'url' },
            output: 'parsed_url'
          },
          {
            name: 'keen:date_time_parser',
            input: { date_time: 'keen.timestamp' },
            output: 'timestamp_inf'
          },
          {
            name: 'keen:ua_parser',
            input: { ua_string: 'user_agent' },
            output: 'parsed_user_agent'
          },
          {
            name: 'keen:referrer_parser',
            input: {
              referrer_url: 'referrer.url',
              page_url: 'url'
            },
            output: 'referrer.info'
          }
        ]
      }
    }
  end
end
