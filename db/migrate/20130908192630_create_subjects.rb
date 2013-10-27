class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :title
      t.text :description
      t.boolean :active
      t.integer :position
      t.integer :parent

      t.timestamps
    end
  end
end
