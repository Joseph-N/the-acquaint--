class MicropostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user, only: :destroy

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
    @id = params[:id]
    @micropost.destroy
    respond_to do |format|
      format.html { redirect_to home_url }
      format.js
    end    
  end

  def check_new_updates
    microposts = Micropost.where("id > ?", params[:id])
    @count = {"id" => microposts.count }
    respond_to do |format|
      format.json { render :json => @count }
    end     
  end

  def load_new_microposts
    @id = params[:id]
    @microposts = Micropost.where("id > ?", @id)
      respond_to do |format|
        format.js
      end
  end

  def load_on_scroll
    @microposts = Micropost.where("id < ?", params[:last_msg_id]).limit(5)
    respond_to do |format|
      format.js
    end
  end

  private

    def correct_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to home_url if @micropost.nil?
    end
end
