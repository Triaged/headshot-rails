module UsersHelper
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

  def company_logo(company)
    content_tag(:div, class: "profile-picture") do
      content_tag(:div, class: "initials-circle") do
        content_tag(:div, class: "initials") do
          concat content_tag(:span, company.name[0])
        end
      end
    end
  end
end
