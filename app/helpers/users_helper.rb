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
  def default_gender_image(user,size)
    if user.gender == "male"
      if size == "small"
        image_tag("default-male-icon.jpg")
      else
         image_tag("male-default-avatar.png")
      end
    else
      if size == "avator"
        image_tag("default-female-icon.jpg")
      else
        image_tag("female-default-avatar.png")
      end
      
    end    
  end
  
  #returns the thubmail for a given user
  def thumbnail_for(user, size)
    if user.photos.any?
      if size == "small"
        image_tag user.photos.first.image.url(:small)
      else
        image_tag user.photos.first.image.url(:avator)
      end      
    else
      default_gender_image(user,size)
    end
  end
  
end
