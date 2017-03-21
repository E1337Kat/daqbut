class AddDescriptionToMemes < ActiveRecord::Migration[5.0]
  def change
    add_column :memes, :description, :text
  end
end
