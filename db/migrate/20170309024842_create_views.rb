class CreateViews < ActiveRecord::Migration[5.0]
  def change
    create_table :views do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :meme, foreign_key: true

      t.timestamps
    end

    add_column :users, :views_count, :integer, null: false, default: 0
    rename_column :memes, :views, :views_count
  end
end
