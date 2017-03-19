class RemovePriceFromMemes < ActiveRecord::Migration[5.0]
  def change
    remove_column :memes, :price, :integer
  end
end
