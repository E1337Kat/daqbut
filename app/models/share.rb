class Share < ApplicationRecord
  belongs_to :meme
  belongs_to :user
end
