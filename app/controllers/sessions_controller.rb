class SessionsController < ApplicationController
  before_filter :initialize_users, only: [:new, :create]
  
  def new
  end
  
  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = "Wrong email/password combination"
      render 'new'
    end
  end
  
  def destroy
    sign_out
    redirect_to root_url    
  end
end
