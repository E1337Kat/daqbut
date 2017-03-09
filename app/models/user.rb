class User < ApplicationRecord
  devise :omniauthable, :trackable, omniauth_providers: [:reddit]

  has_many :memes,  dependent: :destroy
  has_many :shares, dependent: :destroy
  has_many :views,  dependent: :destroy

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create
  end
end
