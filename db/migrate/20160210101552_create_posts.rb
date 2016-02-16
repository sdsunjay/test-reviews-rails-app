class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :description
      t.integer :user_id
      t.integer :number_of_buyers, :default => 0
      t.decimal :price, :default => 0.00, :precision => 8, :scale => 2
      t.timestamps null: false
    end
  end
end
