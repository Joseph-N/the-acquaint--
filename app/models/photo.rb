class Photo < ActiveRecord::Base
  attr_accessible :image
  
  belongs_to :user
  
  has_attached_file :image, :styles => { :small => "50x50#", :thumb => "150x150#", :medium => "250x300#", :large => "500x300#" },
                    :url => "/assets/user_photos/:id/:style/:basename",
                    :path =>":rails_root/public/assets/user_photos/:id/:style/:basename"
end
