class AddAncestryToSubjects < ActiveRecord::Migration
  def up
    add_column :subjects, :ancestry, :string
    add_index :subjects, :ancestry
  end
  
  def down
    remove_index :subjects, :ancestry 
  end
end
