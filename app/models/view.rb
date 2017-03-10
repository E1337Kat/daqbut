class View < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :meme, counter_cache: true

  validates :meme, presence: true

  after_create :update_meme

  private

  def update_meme
    meme.save
  end
end
