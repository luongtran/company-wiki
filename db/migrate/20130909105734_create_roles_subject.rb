class CreateRolesSubject < ActiveRecord::Migration
  def change
    create_table(:roles_subjects, :id => false) do |t|
      t.references :role
      t.references :subject
    end
  end
end
