class UserMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def send_notification(user_id, object_id, action)
    logger = Logger.new('log/mailer.log')
    logger.info("========= Log for sending email ==========")
    @user = User.find(user_id)
    @post = Post.find(object_id)
    @action = action
    @subjects = Subject.joins(:roles).where("subjects.id = ?", @post.subject_id) 
    
    @roles_id = []
    @subjects[0].roles.each do |role|
      @roles_id << role.id
    end
    
    @receivers = User.joins(:roles).where("roles.id IN (?)", @roles_id)
    
    @url_show_post = subject_post_url(@subjects[0], @post)
    logger.info(@url_show_post)
    mail_subject = "#{@user.full_name} just #{action} on the post - #{@post.title}" 
    @receivers.each do |receiver|
      @receiver = receiver
      mail(to: receiver.email, subject: mail_subject)
    end
  end
end
