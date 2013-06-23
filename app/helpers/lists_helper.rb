module ListsHelper

  def mylists(userid)
    @mylists = List.where(user_id: userid.id)
  end
end
