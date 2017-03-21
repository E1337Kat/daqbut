class AddNameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column    :users, :name, :string
    remove_column :users, :uid,  :string
  end
end
