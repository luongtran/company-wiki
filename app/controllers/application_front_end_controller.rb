class ApplicationFrontEndController < ApplicationController
  
  before_filter :get_subjects
  before_filter :check_permission, :except => [:no_permission]
  before_filter :load_new_feeds
  before_filter :authenticate_user!
  
  protected
  
  def get_subjects
    logger = Logger.new('log/menu.log')
    logger.info('----------Log for menu-----------')
    @subjects = Array.new
    
    if current_user
      @roles = current_user.roles
      @roles.each do |role|
        @subjects << role.subjects
      end
    end
    
    logger.info(@subjects)
    @subjects
  end
  
  def check_permission
    
    if params[:controller] == "users"
      return true
    end
    
    if params[:subject_id]
      subject_id = params[:subject_id]
    elsif params[:id] 
      subject_id = params[:id]     
    end
    action = self.prepair_action(params[:action])
    
    if subject_id.nil?
      return true
    end
    
    @logger = Logger.new('log/permission.log')
    @logger.info("=============Log for permission==============")
    @logger.info("action: #{action}")
    @logger.info("subject: #{subject_id}")
    
    is_has_permission = false
    if (user_signed_in? && subject_id)
      is_has_subject = self.is_has_subject(subject_id)
      is_has_permission = self.is_has_permission(action)
      @logger.info("Logged in")
      @logger.info("is has subject #{is_has_subject}")
      @logger.info("is has permission #{is_has_permission}")
      if (is_has_subject && is_has_permission)
        return true
      end
    end
    
    redirect_to no_permission_path
  end
  
  def set_subject
    @subject = Subject.find(params[:subject_id])
  end
  
  def is_has_subject(subject_id)
    is_has_subject = false
    @subjects[0].each do |subject|
      if (subject.id.to_i == subject_id.to_i)
        is_has_subject = true
      end
    end
    is_has_subject
  end
  
  def is_has_permission(action)
    @enable_edit = false
    is_has_permission = false
    permissions = []
    @roles.each do |role|
      permissions << role.permisions
    end
    
    permissions[0].each do |p|
      if p.title == action
        is_has_permission = true
      end
      if p.title == "update"
        @enable_edit = true
      end
    end
    
    is_has_permission
  end
  
  def prepair_action(action)
    
    convert_action = ""
    case action
    when "show"
      convert_action = "view"
    when "edit"
      convert_action = "update"
    when "new"
      convert_action = "create"
    else
      convert_action = action
    end
    
    convert_action
    
  end
  
  def load_new_feeds
    subj_ids = []
    if !@subjects.nil? && @subjects.count && !@subjects[0].nil?
      @subjects[0].each do |subject|
        subj_ids << subject.id
      end
    end
    
    
    posts = Post.find(:all, :conditions => ["subject_id IN (?)", subj_ids])
    
    trackable_ids = []
    posts.each do |post|
      trackable_ids << post.id
    end
    
    user_log_activity_ids = []
    current_user.user_activities_logs.each do |log_activity|
      user_log_activity_ids << log_activity.activity_id
    end
    @activities = PublicActivity::Activity.order("created_at DESC").where("trackable_type IN (?) AND trackable_id IN (?)", ["Post", "Comment"], trackable_ids).all
    @new_activities = Array.new
    @activities.each do |activity|
      if !user_log_activity_ids.include? activity.id
        @new_activities.push(activity)
      end
    end
    
    @number_new_feeds = @new_activities.count
  end
  
end
