class AddGetNotificationToUser < ActiveRecord::Migration
  def change
    add_column :users, :get_notification_to_email, :boolean
  end
end
