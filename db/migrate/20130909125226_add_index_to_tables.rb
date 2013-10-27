class AddIndexToTables < ActiveRecord::Migration
  def change
    add_index(:roles_subjects, [ :role_id, :subject_id ])
    add_index(:roles_permisions, [:role_id, :permision_id])
  end
end
