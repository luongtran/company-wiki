class CreateUserActivitiesLogs < ActiveRecord::Migration
  def change
    create_table :user_activities_logs do |t|
      t.integer :user_id
      t.integer :activity_id

      t.timestamps
    end
  end
end
