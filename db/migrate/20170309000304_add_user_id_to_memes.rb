class AddUserIdToMemes < ActiveRecord::Migration[5.0]
  def change
    add_column :memes, :user_id, :integer, foreign_key: true, index: true
  end
end
