class Meme < ApplicationRecord
  validates :title, :slug, :image, :views, :price, presence: true
  validates :slug, uniqueness: true
end
