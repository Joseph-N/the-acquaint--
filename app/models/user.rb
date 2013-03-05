# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base  
  attr_accessible :email, :name, :username, :gender, :password, :password_confirmation, :photos_attributes
  
  has_secure_password
  ajaxful_rater
  ajaxful_rateable stars: 5, allow_update: false
  acts_as_messageable
  is_impressionable
  acts_as_voteable
  acts_as_voter
  
  has_many :comments, dependent: :destroy
  has_many :photos, dependent: :destroy
  accepts_nested_attributes_for :photos, allow_destroy: true
  has_many :received_messages, :class_name => 'Message', :foreign_key => 'sender_id'
  has_many :sent_messages, :class_name => 'Message', :foreign_key => 'receiver_id'
  
  #Ensure email uniqueness by downcasing the email attribute
  before_save { self.email.downcase! }
  before_save :create_remember_token
  
  validates :name, presence: true, length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :username, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :gender, presence: true
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  
  private
  
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

  def mailboxer_email(object)
    self.email
  end  
end
