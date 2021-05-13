class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :body
      t.integer :user_id
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
