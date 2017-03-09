class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.belongs_to :meme, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.string :reason

      t.timestamps
    end

    add_column :memes, :reports_count, :integer, default: 0, null: false
    add_column :users, :reports_count, :integer, default: 0, null: false
  end
end
