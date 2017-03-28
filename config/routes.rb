Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  resources :memes do
    resources :reports, only: [:new, :create]

    get  'chart'
    get  'buy',  to: 'shares#new_buy'
    get  'sell', to: 'shares#new_sell'
    post 'buy',  to: 'shares#buy'
    post 'sell', to: 'shares#sell'
  end
end
