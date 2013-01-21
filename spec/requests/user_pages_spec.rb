require 'spec_helper'

describe "User Pages" do
  subject { page }
  
  describe "signup page" do
    before { visit signup_path }
    
    it { should have_content('SIGN UP FOR AN ACCOUNT') }
    it { should have_selector('title', text: full_title('Sign Up')) }
  end
  
  describe "signup" do
    before { visit signup_path }
    
    let(:submit) { "Sign Me Up" }
    
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
      
      describe "after submission" do
        before { click_button submit }
        
        it { should have_selector('title', text: full_title('Sign Up')) }
        it { should have_content('error') }
      end
    end
    
    describe "with valid information" do
      before do
        fill_in "name",             with: "Joseph"
        fill_in "Username",         with: "Jose"
        fill_in "Email",            with: "jojoartz@yahoo.com"
        select  "Male",             from: "user_gender"        
        fill_in "Password",         with: "password"
        fill_in "Confirm Password", with: "password"
      end
      
      it "Should create a user" do
        expect { click_button submit}.to change(User, :count).by(1)
      end     
      
      #describe "after saving the user" do
      #  before { click_button submit }
      #  let(:user) { User.find_by_email('jojoartz@yahoo.com') }
        
      #  it { should have_selector('h4',text: 'Hi #{user.name}' )}
      #  it { should have_link('Sign Out')}
      #end
    end
  end
end
