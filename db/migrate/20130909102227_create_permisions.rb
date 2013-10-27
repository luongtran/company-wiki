class CreatePermisions < ActiveRecord::Migration
  def change
    create_table :permisions do |t|
      t.string :title
      t.boolean :active

      t.timestamps
    end
  end
end
