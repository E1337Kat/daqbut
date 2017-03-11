class View < ApplicationRecord
  belongs_to :meme, counter_cache: true
  belongs_to :user, counter_cache: true, optional: true

  validates :meme, presence: true
end
