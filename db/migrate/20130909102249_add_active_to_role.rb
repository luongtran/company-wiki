class AddActiveToRole < ActiveRecord::Migration
  def change
    add_column :roles, :active, :boolean
  end
end
