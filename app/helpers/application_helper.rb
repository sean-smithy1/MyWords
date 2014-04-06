module ApplicationHelper
#Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "MyWords"
    if page_title.empty?
     base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

# Flash error messages w/ bootstrap styling
  def bootstrap_class_for flash_type
    case flash_type
      when :success
        "alert alert-success"
      when :error
        "alert alert-danger"
      when :alert
        "alert alert-warning"
      when :notice
        "alert alert-info"
    else
      flash_type.to_s
    end
  end

#JQuery to add/remove individual words

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end

end
