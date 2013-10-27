class Post < ActiveRecord::Base
  
  versioned
  
  acts_as_commentable
  
  attr_accessible :body, :publish, :subject_id, :title, :user_id
  
  belongs_to :subject
  belongs_to :user
  
  after_save :send_notification_email
  
  include PublicActivity::Model

  tracked :owner => proc {|controller, model| controller.current_user}, # set owner to current_user by default (check app/controllers/application_controller.rb)
          :params => {
            :summary => proc {|controller, model| controller.truncate(model.body, length: 30)}   # by default save truncated summary of the post's body
          }
          
  def send_notification_email
    activity = PublicActivity::Activity.last
    UserMailer.delay.send_notification(self.user_id, self.id, activity.key)
  end
  
end
