class User < ApplicationRecord
  REFERRAL_REWARD = (ENV['REFERRAL_REWARD'] || 500).to_i.freeze

  devise :omniauthable, :trackable, omniauth_providers: [:reddit]

  has_many :memes,   dependent: :destroy
  has_many :shares,  dependent: :destroy
  has_many :reports, dependent: :destroy

  has_many   :referrees, class_name: 'User',
                         foreign_key: :referrer_id
  belongs_to :referrer,  class_name: 'User',
                         counter_cache: :referrees_count,
                         optional: true

  after_create :reward_referral

  def self.from_omniauth(auth)
    where(provider: auth.provider, name: auth.info.name).first_or_create
  end

  private

  def reward_referral
    self.referrer.increment!(:points, REFERRAL_REWARD)
  end
end
