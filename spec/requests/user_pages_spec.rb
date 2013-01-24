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
        fill_in "user[name]",                   with: "Joseph"
        fill_in "user[username]",               with: "Jose"
        fill_in "user[email]",                  with: "jojoartz@yahoo.com"
        select  "Male",                         from: "user[gender]"        
        fill_in "user[password]",               with: "password"
        fill_in "user[password_confirmation]",  with: "password"
      end
      
      it "Should create a user" do
        expect { click_button submit}.to change(User, :count).by(1)
      end     
      
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email('jojoartz@yahoo.com') }
        
        it { should have_selector('h4',text: 'Hi Joseph' )}
        it { should have_link('Sign Out')}
      end
    end
  end
  
  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user) 
    end
    
    describe "page" do
      it { should have_selector('title', text: full_title('Edit Profile')) }
      it { should have_selector('h3', text: 'Update your profile') }
    end
    
    describe "with invalid information" do
      before { click_button "Update Profile" }
      
      it { should have_content('error') }
    end
    
    describe "With valid information" do
      let(:new_name) { "Arlus" }
      let(:new_email) { "arlus@gmail.com" }
      let(:new_username) { "Mago455 "}
      before do
        fill_in "user[name]",                   with: new_name
        fill_in "user[username]",               with: new_username
        fill_in "user[email]",                  with: new_email
        select  "Male",                         from: "user[gender]"        
        fill_in "user[password]",               with: user.password
        fill_in "user[password_confirmation]",  with: user.password
        
        click_button "Update Profile"
      end
      
      it { should have_selector('title', text: full_title(new_name)) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign Out', href: signout_path) }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }
      specify { user.reload.username.should == new_username }
    end
  end
  
  describe "index" do
    
    let(:user) { FactoryGirl.create(:user)}
    
     before(:each) do
       sign_in user
       visit users_path
     end
    
    it { should have_selector('title', text: 'All users') }
    it { should have_selector('h1', text: 'All users')}
    
    describe "pagination" do
      
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all) { User.delete_all }
      
      it { should have_selector('div.pagination') }
      
      it "should list each user" do
        User.paginate(page: 1).each do |user|
          page.should have_selector('li', text: user.name)
        end
      end
    end    
  end
end
