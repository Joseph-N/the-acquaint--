class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :show, :index]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :initialize_users, only: [:new, :create]
  
  def index
    @users = User.paginate(page: params[:page], :per_page => 10)
  end
  
  def new
    if signed_in?
      redirect_to current_user
    else
      @user = User.new
    end
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      redirect_to @user
    else
     render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
    @comments = @user.comments
    @comment = current_user.comments.build 
    @profile_pic = @user.photos.first
  end
  
  def edit
    @user = User.find(params[:id])  
    remaining_uploads(@user).times { @user.photos.build }
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile Updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end    
  end
  
  private
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def remaining_uploads(user)
      max_photos = 4
      user_photos = user.photos.count
      diff = max_photos - user_photos            
    end
end
