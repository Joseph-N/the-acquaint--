class Comment < ActiveRecord::Base
  attr_accessible :content
  
  belongs_to :user
  belongs_to :commenter, foreign_key: 'commenter_id', class_name: 'User'
  
  validates :user_id, presence: :true
  validates :commenter_id, presence: :true
  validates :content, presence: :true, length: { maximum: 255 }
end
