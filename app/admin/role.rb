ActiveAdmin.register Role do
  
  controller do
    def create
      @role = Role.new(params[:role])
      if @role.save
        redirect_to admin_roles_path, flash[:info] => "Save successfully"
      else
        redirect_to new_admin_role_path, flash[:error] => "Cannot be saved"
      end
    end
  end
  
  show do
    h3 role.name
    
    div  do
      h2 "Permision"
      
      role.permisions.each do |p|
        span "title: #{p.title}"  
        br
      end
    end
    div do
      h2 "Subjects"
      role.subjects.each do |subject|
        span link_to subject.title, admin_subject_path(subject)
      end
    end
  end
  
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Role" do
      f.input :name
    end
    f.inputs "Permissions" do
      f.input :permisions, :as => :check_boxes
    end
    
    f.inputs "Subjects" do 
      f.input :subjects, :as => :check_boxes
    end
    
    f.actions
  end
end
