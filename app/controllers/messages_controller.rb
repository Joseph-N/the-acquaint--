class MessagesController < ApplicationController
  before_filter :signed_in_user
  
  def index
    @user = User.find(params[:user_id])
    @conversation = @user.mailbox.inbox.first
    @receipts = @conversation.receipts_for @user   
  end
  
  def show
     
  end
  
  
end