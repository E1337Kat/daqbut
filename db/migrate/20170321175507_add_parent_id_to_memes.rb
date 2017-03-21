class AddParentIdToMemes < ActiveRecord::Migration[5.0]
  def change
    add_column :memes, :parent_id, :integer, foreign_key: true
  end
end
