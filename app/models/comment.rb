class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true

  default_scope :order => 'created_at ASC'

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # NOTE: Comments belong to a user
  belongs_to :user
  
  attr_accessible :user_id, :comment
  
  after_save :send_notification_email
  
  def send_notification_email
    activity = PublicActivity::Activity.last
    UserMailer.delay.send_notification(self.user_id, self.commentable_id, activity.key)
  end
  
end
