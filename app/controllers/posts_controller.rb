class PostsController < ApplicationFrontEndController
  
  before_filter :set_subject #, :except => [:show]
  
  after_filter :create_activities_log, :only => [:show]
  
  def show
    @post = Post.find(params[:id])
    @post.revert_to(params[:version]) if params[:version]
    @comment = @post.comments.new
    @comments = @post.comments
    
    @activities = PublicActivity::Activity.order("created_at DESC").where(trackable_type: "Post", trackable_id: @post).all
    
    @user_activities_log = []
    @activities.each do |activity|
      if activity.owner_id == current_user.id
        user_activity = UserActivitiesLog.new({:activity_id => activity.id, :user_id => current_user.id})
        @user_activities_log << user_activity
      end
    end
    
    UserActivitiesLog.import @user_activities_log
    
    respond_to do |format|
      format.html
    end
  end
  
  def index
    @posts = @subject.posts
  end
  
  def new
    @post = @subject.posts.new
  end
  
  def create
    @post = @subject.posts.new(params[:post])
    @post.user_id = current_user.id
    if @post.save
      redirect_to subject_post_path(@subject, @post), flash[:success] => "Post saved successfully"
    end
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to subject_post_path(@subject, @post), flash[:success] => "Post updated successfully"
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    
  end
  
  private 
  
  def create_activities_log
    user_ac_logs = []
    @activities.each do |activity|
      user_ac_logs << {:user_id => current_user.id, :activity_id => activity.id}
    end
    UserActivitiesLog.create(user_ac_logs)
  end
  
end
