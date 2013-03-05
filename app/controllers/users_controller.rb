class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :show, :index]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :initialize_users, only: [:new, :create]
  impressionist :actions => [:show], :unique => [:impressionable_id, :session_hash]
  
  def index
    
    @most_popular = User.find_most_popular
    @typeahead = User.select(:name).to_json
    @rank = rank
    #cluttered see model to clean this up
    #for heroku pg user ilike in query to eliminate case sensitive searches
    if params[:search]
      @users = User.paginate(:conditions => ['name LIKE ? OR username LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%"], page: params[:page], :per_page => 10)
    else
      @users = User.paginate(page: params[:page], :per_page => 10)
    end
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
    @average = @user.rate_average
    @rank = rank.index(@average)
    session[:user_email] = @user.email
    session[:user_name] = @user.name
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
  
  def rate
    @user = User.find(params[:id])
    @user.rate(params[:stars], current_user, params[:dimension])
    respond_to do |format|
      format.js
    end
  end

  def vote_up
    @voter = User.find(params[:id])
    voteable = current_user
    begin
      if @voter.voted_on?(voteable)
        @voter.vote_exclusively_for(voteable)
      else
        @voter.vote_for(voteable)
      end
      respond_to do |format|
        format.html { redirect_to @voter }
        format.js
      end
    rescue ActiveRecord::RecordInvalid
        redirect_to @voter
    end     
  end

  def vote_down
    @voter = User.find(params[:id])
    voteable = current_user
    begin
      if @voter.voted_on?(voteable)
        @voter.vote_exclusively_against(voteable)
      else
        @voter.vote_against(voteable)
      end
      respond_to do |format|
        format.html { redirect_to @voter }
        format.js
      end
    rescue ActiveRecord::RecordInvalid
        redirect_to @voter
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
    
    def rank
      users = User.all
      scores = []
      for user in users do
        scores.push(user.rate_average)
      end
      scores.sort!.reverse!
    end
    
end
