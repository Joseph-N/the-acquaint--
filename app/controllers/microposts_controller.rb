class MicropostsController < ApplicationController
  before_filter :signed_in_user

  def create
  	@micropost = current_user.microposts.build(params[:micropost])
  	if @micropost.save
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
  	else
      @most_popular = User.find_most_popular
  		render 'static_pages/home'
  	end
  end

  def destroy
  end
end