class Meme < ApplicationRecord
  belongs_to :user

  validates :title, :slug, :image, :views, :price, presence: true
  validates :slug, uniqueness: true

  mount_uploader :image, MemeUploader

  def title=(value)
    self.slug = Text::Metaphone.metaphone(value).gsub(/\W/, '')
    self.slug = slug.next while Meme.where(slug: slug).any?
    super
  end
end
