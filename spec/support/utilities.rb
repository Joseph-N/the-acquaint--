def full_title(page_title)
  default_title = "The Acquiant"
  if page_title.empty?
    default_title
  else
    "#{default_title} | #{page_title}"
  end
  
  def sign_in(user)
    visit signin_path
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    
    # Sign in when not using Capybara as well.
    cookies[:remember_token] = user.remember_token
  end
end
