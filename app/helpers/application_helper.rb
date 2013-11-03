module ApplicationHelper
  
  def render_tree_menu(subjects)
    subjects.map do |subject, sub_subjects|
      if subject.has_children?
        render(subject) + content_tag(:ul, render_tree_menu(sub_subjects), :class => "nav.nav-tabs.nav-stacked")
      else
        render(subject)
      end
      
    end.join.html_safe
  end
  
  def timeago(time, options = {})
    options[:class] ||= "timeago"
    content_tag(:abbr, time.to_s, options.merge(:title => time.getutc.iso8601)) if time
  end

  # Shortcut for outputing proper ownership of objects,
  # depending on who is looking
  def whose?(user, object)
    
    whose = ""
    
    case object
      when Post
        
        owner = object.user
      when Comment
        
        owner = object.user
      else
        
        owner = nil
    end
   
    if user and owner
      
      if user.id == owner.id
        whose = "his"
      else
        whose = "#{owner.full_name}'s"
      end
    else
      ""
    end
    
    whose
  end

  # Check if object still exists in the database and display a link to it,
  # otherwise display a proper message about it.
  # This is used in activities that can refer to
  # objects which no longer exist, like removed posts.
  def link_to_trackable(object, object_type)
    if object
      subject = object.subject
      link_to object_type.downcase, [subject, object], :class => "btn btn-mini btn-success"
    else
      "a #{object_type.downcase} which does not exist anymore"
    end
  end
  
end
