module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-danger alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

   def bootstrap_class_for(flash_type)
    case flash_type
      when "success"
        "alert-success"   # Green
      when "error"
        "alert-danger"    # Red
      when "alert"
        "alert-warning"   # Yellow
      when "notice"
        "alert-info"      # Blue
      else
        flash_type.to_s
    end
  end


  def avatar_or_initials(user, profile_class)
    content_tag(:div, class: profile_class) do
      if user.avatar?
        concat image_tag( user.avatar.url, class: "picture-frame")
      else
        content_tag(:div, class: "initials-circle") do
          content_tag(:div, class: "initials") do
            concat content_tag(:span, user.initials)
          end
        end
      end
    end
  end

end
