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
      if size == "small"
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
        image_tag user.photos.first.image.url(:small), alt: user.name, width: "50", height: "50"
      else
        image_tag user.photos.first.image.url(:avator), alt: user.name, width: "200", height: "150"
      end      
    else
      default_gender_image(user,size)
    end
  end
  
  #returns avator for highest rated user
  def avator_for(user, gender)
    if user.photos.any?
      image_tag user.photos.first.image.url(:rated), alt: user.name, width: "250", height: "250", title: user.name
    else
      if gender == "male"
        image_tag "default_rated_male.png",alt: user.name, width: "250", height: "250",title: user.name
      else
        image_tag "default_rated_female.png",alt: user.name, width: "250", height: "250", title: user.name
      end
    end
  end

  def profile_pic(user)
    image_tag user.photos.first.image.url(:small),
               alt: user.name,width: "25",
               height: "25", title: user.name,
               style: "margin-top: -2px;"
  end

  
  #returns text_helper for average rating
  def average_text(score)
    case score
    when 0
      'Not yet rated'
    when 1
      'Not attractive'
    when 2
      'Respectable'
    when 3
      'Decent or Attractive'
    when 4
      'Girlfriend Material'
    else
      'Supper Hottie'
    end      
  end
  
  #returns average as a percentage
  def percentagize(average)
    number_with_precision(((average / 10) * 100), precision: 1)
  end
  
end
