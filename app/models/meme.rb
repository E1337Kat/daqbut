class Meme < ApplicationRecord
  REPORT_THRESHOLD = (ENV['REPORT_THRESHOLD'] || 3).to_i.freeze

  has_many :views,   dependent: :destroy
  has_many :shares,  dependent: :destroy
  has_many :reports, dependent: :destroy
  belongs_to :user

  validates :title, :slug, :image, presence: true
  validates :slug, uniqueness: true
  validates :title, length: { maximum: 32 }
  validates :slug, length: { maximum: 8 }

  before_save :set_slug
  before_save :set_price

  scope :visible, -> { where(hidden: false) }
  scope :hidden,  -> { where(hidden: true) }

  mount_uploader :image, MemeUploader

  def buy(user)
    if user.points >= price
      user.increment!(:points, -price)
      Share.create(meme: self, user: user)
      true
    else
      false
    end
  end

  def sell(user)
    if user.shares.where(meme: self).any?
      user.increment!(:points, price)
      Share.where(meme: self, user: user).first.destroy
      true
    else
      false
    end
  end

  def update_hidden!
    update_columns(hidden: true) if reports_count > REPORT_THRESHOLD
  end

  private

  def set_slug
    self.slug ||= Text::Metaphone.metaphone(title).gsub(/\W/, '')
    self.slug = slug.upcase
  end

  def set_price
    self.price = (views_count * shares_count) + 1
    $redis.lpush(slug, price)
  end
end
