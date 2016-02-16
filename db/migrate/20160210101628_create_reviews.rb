class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :title
      t.string :description
      t.integer :rating
      t.integer :user_id
      t.integer :post_id
      t.integer :reviewee_id

      t.timestamps null: false
    end
  end
end
