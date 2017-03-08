class CreateMemes < ActiveRecord::Migration[5.0]
  def change
    create_table :memes do |t|
      t.string  :title, null: false
      t.string  :slug,  null: false
      t.string  :image, null: false
      t.integer :views, null: false, default: 0
      t.integer :price, null: false, default: 1

      t.timestamps
    end

    add_index :memes, :slug, unique: true
  end
end
