class Meme < ApplicationRecord
  has_many :views,  dependent: :destroy
  has_many :shares, dependent: :destroy
  belongs_to :user

  validates :title, :slug, :image, presence: true
  validates :slug, uniqueness: true

  mount_uploader :image, MemeUploader

  def title=(value)
    self.slug = Text::Metaphone.metaphone(value).gsub(/\W/, '')
    self.slug = slug.next while Meme.where(slug: slug).any?
    super
  end

  def buy(user)
    if user.points >= price
      User.increment!(:points, -price)
      Share.create(meme: self, user: user)
      true
    else
      false
    end
  end

  def sell(user)
    if user.shares.where(meme: self).any?
      User.increment!(:points, price)
      Share.where(meme: self, user: user).first.destroy
      true
    else
      false
    end
  end
end
