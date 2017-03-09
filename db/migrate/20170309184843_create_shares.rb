class CreateShares < ActiveRecord::Migration[5.0]
  def change
    create_table :shares do |t|
      t.belongs_to :meme, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.timestamp :sold_at

      t.timestamps
    end

    add_column :memes, :shares_count, :integer, null: false, default: 0
    add_column :users, :shares_count, :integer, null: false, default: 0
  end
end
