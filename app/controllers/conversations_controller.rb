class ConversationsController < ApplicationController
  before_filter :signed_in_user
  helper_method :mailbox, :conversation, :unread_messages, :get_sender

  def index
    @conversations = current_user.mailbox.inbox.paginate(page: params[:page], :per_page => 5)
    @trash = current_user.mailbox.trash
    @sent = current_user.mailbox.sentbox
  end

  def create
    recipient_emails = session[:user_email]
    # recipient_emails = conversation_params(:recipients).split(',')
    recipients = User.where(email: recipient_emails).all

    conversation = current_user.
      send_message(recipients, *conversation_params(:body, :subject)).conversation

    redirect_to conversation
  end

  def show
    @receipts = conversation.receipts_for(current_user)
  end

  def new
    # @conversation = Conversation.new
  end

  def reply
    current_user.reply_to_conversation(conversation, *message_params(:body, :subject))
    redirect_to conversation
  end

  def trash
    conversation.move_to_trash(current_user)
    redirect_to :conversations
  end

  def untrash
    conversation.untrash(current_user)
    redirect_to :conversations
  end

  private

  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end

  def conversation_params(*keys)
    fetch_params(:conversation, *keys)
  end

  def message_params(*keys)
    fetch_params(:message, *keys)
  end

  def fetch_params(key, *subkeys)
    params[key].instance_eval do
      case subkeys.size
      when 0 then self
      when 1 then self[subkeys.first]
      else subkeys.map{|k| self[k] }
      end
    end
  end

  def unread_messages
    current_user.mailbox.inbox({:is_read => false}).count
  end

  def get_sender(subject)
    sender_id = Notification.select(:sender_id).where(:subject => subject)
    User.find_by_id(sender_id)
  end

end