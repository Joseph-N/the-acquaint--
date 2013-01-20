module UsersHelper
  
  #returns default image for a given gender
  def gravator_for(user)
    if user.gender == "male"
      image_tag("user-male-icon.png")
    else
      image_tag("user-female-icon.png")
    end
  end
end
