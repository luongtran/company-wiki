class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.integer :user_id
      t.boolean :publish
      t.integer :subject_id

      t.timestamps
    end
  end
end
