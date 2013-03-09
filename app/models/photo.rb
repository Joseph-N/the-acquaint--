class Photo < ActiveRecord::Base
  attr_accessible :image
  
  belongs_to :user
    
  has_attached_file :image, :styles => { :small => "", :thumb => "", :avator => "", :rated => "", :medium => "", :hrated => "" },
                    :convert_options => { 
                      :small => "-gravity north -thumbnail 50x50^ -extent 50x50" ,
                      :thumb => "-gravity north -thumbnail 150x150^ -extent 150x150",
                      :avator => "-gravity north -thumbnail 200x150^ -extent 200x150",
                      :rated => "-gravity north -thumbnail 250x250^ -extent 250x250",
                      :medium => "-gravity north -thumbnail 250x300^ -extent 250x300",
                      :hrated => "-gravity north -thumbnail 130x130^ -extent 130x130"
                    },
                    :default_url => "/assets/user_photos/default.jpg",
                    :url => "/assets/user_photos/:id/:style/:basename",
                    :path =>":rails_root/public/assets/user_photos/:id/:style/:basename"
end
