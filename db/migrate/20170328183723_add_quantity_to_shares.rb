class AddQuantityToShares < ActiveRecord::Migration[5.0]
  def change
    add_column :shares, :quantity, :integer, default: 0, null: false
    remove_column :users, :shares_count, :integer
    remove_column :memes, :shares_count, :integer

    Share.find_each do |share|
      primary_share = Share.where(user: share.user, meme: share.meme).first
      if share.id == primary_share.id
        share.update(quantity: 1)
      else
        primary_share.increment!(:quantity, 1)
        share.destroy
      end
    end
  end
end
