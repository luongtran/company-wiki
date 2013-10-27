class CreateRolePermision < ActiveRecord::Migration
  def change
    create_table(:roles_permisions, :id => false) do |t|
      t.references :role
      t.references :permision
    end
  end
end
