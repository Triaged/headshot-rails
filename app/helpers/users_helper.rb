module UsersHelper
	def avatar_or_initials(user, profile_class)
    content_tag(:div, class: profile_class) do
      if user.avatar?
        concat cl_image_tag(user.avatar.face.url, class: "picture-frame")
      else
        content_tag(:div, class: "initials-circle") do
          content_tag(:div, class: "initials") do
            concat content_tag(:span, user.initials)
          end
        end
      end
    end
  end

  def company_logo(company)
    content_tag(:div, class: "profile-picture") do
      if company.logo?
        concat cl_image_tag(company.logo.url)
      else
        content_tag(:div, class: "initials-circle") do
          content_tag(:div, class: "initials") do
            concat content_tag(:span, company.initial)
          end
        end
      end
    end
  end
end
