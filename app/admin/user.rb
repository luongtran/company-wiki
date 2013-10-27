ActiveAdmin.register User do
  
  controller do 
    def create
      @user = User.new(params[:user])
      if @user.save
        redirect_to admin_user_path(@user), flash[:success] => "User has saved successfully"
      else
        #response_with @user
        redirect_to new_admin_user_path, flash[:error] => "User cannot be saved"
      end
    end
  end
  
  show do
    h2 "#{user.first_name} #{user.last_name}"
    h3 "Information"
    div :class => "information" do
      div :class => "field" do
        label :email
        span user.email
      end
      
      div :class => "field" do
        label :department
        span user.department
      end
    end
    
    br
    
    div :class => "information" do
      h3 "Role"
      user.roles.each do |role|
        div do
          h4 role.name
          
          div :class => 'subject' do
            h3 "Subject"
            role.subjects.each do |subject|
              h4 subject.title
            end
          end
        end
        
        div :class => 'permission' do
          h3 "Permission"
          role.permisions.each do |permision|
            span "#{permision.title}, "
          end      
        end
      end
    end
    
  end
  
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Information" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :department
    end
    
    f.inputs "Role" do
      f.input :roles, :as => :check_boxes
    end
    
    f.actions
  end
end
