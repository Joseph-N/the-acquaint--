# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Acquianter::Application.initialize!

# Send mail using gmail smtp
ActionMailer::Base.smtp_settings = {
    :tls => true,
    :address => "smtp.gmail.com",
    :port => "587",
    :domain => "http://fathomless-falls-8042.herokuapp.com/",
    :authentication => :plain,
    :user_name => "jojoartz98@gmail.com",
    :password => "Joseph@Jojo002"
  }

