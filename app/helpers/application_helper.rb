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
       "alert-danger"   # Yellow
     when "notice"
       "alert-info"      # Blue
     else
       flash_type.to_s
   end
 end

  def date_mdY(date)
    if date.nil?
      ""
    else
      date.strftime("%m-%d-%Y")
    end
  end

  def image_tag_with_at2x(name_at_1x, options={})
    name_at_2x = name_at_1x.gsub(%r{\.\w+$}, '@2x\0')
    image_tag(name_at_1x, options.merge("data-at2x" => asset_path(name_at_2x)))
  end

end
