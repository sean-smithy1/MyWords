module ListsHelper

  def list_owner?(listid)
    !current_user.lists.find_by_id(listid).nil?
  end

end
