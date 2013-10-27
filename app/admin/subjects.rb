ActiveAdmin.register Subject do
   #sortable tree: true
   sortable tree: true, # default
   sorting_attribute: :position,
   parent_method: :parent,
   children_method: :children,
   roots_method: :roots
   
   index :as => :sortable do
      label :title # item content
      default_actions
    end
   
   # index do
      # @subjects = Subject.where('parent is null || parent = 0').order('position DESC')
      # render partial: "admin/subjects/index", :locals => {:subjects => @subjects}
    # end
  
  # controller do
    # def roots
      # @subjects = Subject.where(:id => params[:p_id])
      # respond_to do |f|
        # f.json { render :json => @subjects.to_json } #(:include => {:children => {:only => [:id, :name]}})
      # end
    # end
#     
    # def childrens_of
      # logger = Logger.new('log/debug_tree.log')
      # logger.info('Log for getting children of node')
      # @subjects = Subject.where(:parent => params[:p_id])
      # logger.info(@subjects)
      # respond_to { |f| f.json { render :json => @subjects.to_json } }
    # end
#   
    # def subject_infor
      # @subject = Subject.find params[:p_id]
      # respond_to do |f|
        # f.js { render :template => 'admin/subjects/find_subject' }
      # end
    # end
#   
    # def reorder
      # packets = Subject.select("id, title, position").where(:parent => nil).order("position DESC")
      # new_order = params[:new_order].split(',')
      # old_position = []
      # packets.each do |a|
        # old_position << [a.position]
      # end
      # new_order.each_with_index do |id, index|
        # Subject.find(id).update_column('position', old_position[index])
      # end
      # render :nothing => true
    # end
#     
  # end
  
  
  
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :title
      f.input :description
      f.input :active
      f.input :parent_id, :as => :select, :include_blank => true, :collection => Subject.all
    end
    
    f.actions
    
  end
  
  
  sidebar "Informations" do
    ul do
      "Total subjects: " + Subject.all.count.to_s
    end
  end

  filter :title
  
end
