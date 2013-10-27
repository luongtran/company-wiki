class UsersController < ApplicationFrontEndController
  
  def show
    @user = User.find(params[:id])
    
  end
  
  def my_page
    @my_activities = PublicActivity::Activity.order("created_at DESC").where("owner_id = ?", current_user.id).all
  end
  
  def ajax_update_avatar
    @logger = Logger.new('log/user.log');
    @logger.info("================ Log for update avatar ================")
    @user = current_user
    @logger.info(@user)
    @logger.info(params[:user])
   
    if @user.update_attributes(params[:user])
      @success = true
    else
      @success = false
    end
    
    render :json => {:success => @success, :avatar_url => @user.avatar.url(:medium)} 
  end
  
  def user_update_profile
    @logger = Logger.new('log/user.log');
    @logger.info("============== Log for user update profile ================")
    @user = current_user
    @message = ""
    if params[:user][:password]
      if params[:user][:password] == params[:user][:password_confirmation]
        if @user.reset_password!(params[:user][:password],params[:user][:password_confirmation])
          @user.save
          @success = true
          @message = "Your password changed successfully"
        end
      else
        @success = false
        @message = "Password and password confirmation do not match"
      end
    else
      if @user.update_attributes(params[:user])
        @logger.info(params[:user])
        @success = true
        @message = "Your profile updated successfully"
      else
        @success = false
        @message = "Your profile update cannot be saved"
      end
    end
    @logger.info(@message)
    render :json => {:success => @success, :message => @message}
    
  end
  
end
