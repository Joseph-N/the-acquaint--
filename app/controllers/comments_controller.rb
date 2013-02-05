class CommentsController < ApplicationController
  before_filter :signed_in_user

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
  end
end