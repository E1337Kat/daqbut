class User < ApplicationRecord
  devise :omniauthable, :trackable, omniauth_providers: [:reddit]

  has_many :memes,   dependent: :destroy
  has_many :shares,  dependent: :destroy
  has_many :views,   dependent: :destroy
  has_many :reports, dependent: :destroy

  has_many   :referrees, class_name: 'User',
                         foreign_key: :referrer_id
  belongs_to :referrer,  class_name: 'User',
                         counter_cache: :referrees_count,
                         optional: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create
  end
end
