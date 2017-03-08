class Meme < ApplicationRecord
  validates :title, :slug, :image, :views, :price, presence: true
  validates :slug, uniqueness: true

  def title=(value)
    self.slug = Text::Metaphone.metaphone(value).gsub(/\W/, '')
    self.slug = slug.next while Meme.where(slug: slug).any?
    super
  end
end
