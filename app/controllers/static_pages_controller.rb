class StaticPagesController < ApplicationController
  def about
  end

  def home
  	if signed_in?
  		@most_popular = User.find_most_popular
	  	@micropost = current_user.microposts.build 
	  	@microposts = Micropost.limit(5)
	end
  end
end
