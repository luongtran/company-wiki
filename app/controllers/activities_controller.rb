class ActivitiesController < ApplicationFrontEndController
  
  layout false, only: :show
  

  def feed
    @activities = PublicActivity::Activity.order("created_at DESC").all

    respond_to do |format|
      format.html
    end
  end

  def yours
    @activities = PublicActivity::Activity.order("created_at DESC").where(owner_type: "User", owner_id: current_user).all

    respond_to do |format|
      format.html
    end
  end

  def show
    @activity = PublicActivity::Activity.find(params[:id])

    respond_to do |format|
      format.html
    end
  end
  
end
