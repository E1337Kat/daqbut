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
end
