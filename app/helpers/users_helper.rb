module UsersHelper
  
  #returns default large image for a given gender
  def gravator_for(user)
    if user.gender == "male"
      image_tag("user-male-icon.png")
    else
      image_tag("user-female-icon.png")
    end
  end
  
  #returns a default small image for a given gender
  def default_gender_image(user)
    if user.gender == "male"
      image_tag("default-male-icon.jpg")
    else
      image_tag("default-female-icon.jpg")
    end    
  end
  
  #returns the thubmail for a given user
  def thumbnail_for(user)
    if user.photos.any?
      image_tag user.photos.first.image.url(:small)
    else
      default_gender_image(user)
    end
  end
  
end
