module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Abilitree InTouch"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def user_admin(current_user)
    if (current_user.user_type == 'admin')
      return true
    else
      return false
    end
  end

end
