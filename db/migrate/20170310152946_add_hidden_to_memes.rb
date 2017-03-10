class AddHiddenToMemes < ActiveRecord::Migration[5.0]
  def change
    add_column :memes, :hidden, :boolean, default: false, null: false
  end
end
