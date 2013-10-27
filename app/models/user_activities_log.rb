class UserActivitiesLog < ActiveRecord::Base
  attr_accessible :activity_id, :user_id
  
  validates_uniqueness_of :activity_id, :scope => :user_id
  
  belongs_to :user
end
