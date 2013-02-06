class CommentsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,   only: :destroy

  def create
    @user = User.find(params[:user_id])
    @comment = @user.comments.build(params[:comment])
    @comment.commenter_id = current_user.id
    if @comment.save
      redirect_to @user
    else
      flash[:error] = "There was a problem posting your comment"
      redirect_to @user
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @comment = @user.comments.find(params[:id])
    @comment.destroy
    redirect_to @user
  end
  
  private
  def correct_user
    @comment = current_user.comments.find_by_id(params[:id])
    redirect_to root_url if @comment.nil?
  end
  
end