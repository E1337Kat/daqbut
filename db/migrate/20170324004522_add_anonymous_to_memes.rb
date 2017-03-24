class AddAnonymousToMemes < ActiveRecord::Migration[5.0]
  def change
    add_column :memes, :anonymous, :boolean, default: false, null: false
  end
end
