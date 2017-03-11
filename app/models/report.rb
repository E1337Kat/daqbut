class Report < ApplicationRecord
  belongs_to :meme, counter_cache: true
  belongs_to :user, counter_cache: true, optional: true

  validates :meme, presence: true

  after_save :update_meme_hidden

  private

  def update_meme_hidden
    meme.update_hidden!
  end
end
