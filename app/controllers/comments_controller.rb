class CommentsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,   only: :destroy

  def create
    @user = User.find(params[:user_id])
    @comment = @user.comments.build(params[:comment])
    @comment.commenter_id = current_user.id
    if @comment.save
      respond_to do |format|
        format.html { redirect_to @user }
        format.js
      end
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @comment = @user.comments.find(params[:id])
    @comment.destroy
    redirect_to @user
  end

  def more_comments
    @user = User.find(params[:id]);
    @last_msg_id = params[:lastmsg]
    @comments = @user.comments.where("id < ?", @last_msg_id).order("id DESC").limit(5).sort
    @new_last_msg_id = (@comments.any?) ? (@comments.first.id) : 0
    respond_to do |format|
      format.js
    end
  end
  
  private
  def correct_user
    @comment = current_user.comments.find_by_id(params[:id])
    redirect_to root_url if @comment.nil?
  end
  
end