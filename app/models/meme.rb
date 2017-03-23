class Meme < ApplicationRecord
  REPORT_THRESHOLD   = (ENV['REPORT_THRESHOLD']   || 3).to_i.freeze
  STANDARD_MEME_FEE  = (ENV['STANDARD_MEME_FEE']  || 10).to_i.freeze
  TOP_LEVEL_MEME_FEE = (ENV['TOP_LEVEL_MEME_FEE'] || 100).to_i.freeze

  has_many :shares,  dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :children, class_name: 'Meme', foreign_key: :parent_id
  belongs_to :user
  belongs_to :parent, optional: true, class_name: 'Meme'

  validates :title, :slug, :image, presence: true
  validates :slug,  uniqueness: true
  validates :title, length: { maximum: 32 }
  validates :slug,  length: { maximum: 8 }
  validates :slug, exclusion: { in: %w(DAQBUT),
                                message: "%{value} is a reserved ticker name." }

  before_save   :set_slug
  after_create  :add_initial_prices

  scope :visible, -> { where(hidden: false) }
  scope :hidden,  -> { where(hidden: true) }

  mount_uploader :image, MemeUploader

  def fee
    parent_id.nil? ? TOP_LEVEL_MEME_FEE : STANDARD_MEME_FEE
  end

  def parent_slug=(slug)
    self.parent = Meme.find_by(slug: slug)
  end

  def price
    @price ||= $redis.lindex(slug, -1).to_i
  end

  def price_difference
    @price_difference ||= $redis.lindex(slug, -1).to_i - $redis.lindex(slug, -2).to_i
  end

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

  def add_initial_prices
    price = 0
    100.times do
      $redis.rpush(slug, [price, 1].max)
      price += rand(100) - 50
    end
  end
end
