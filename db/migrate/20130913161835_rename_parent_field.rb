class RenameParentField < ActiveRecord::Migration
  def change
    rename_column :subjects, :parent, :parent_id
  end
end
