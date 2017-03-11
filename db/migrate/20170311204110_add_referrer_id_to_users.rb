class AddReferrerIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :referrer_id,     :integer, foreign_key: true
    add_column :users, :referrees_count, :integer, null: false, default: 0
  end
end
