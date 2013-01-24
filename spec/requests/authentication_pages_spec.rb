require 'spec_helper'

describe "Authentication" do
  subject { page }
  
  describe "signin page" do
    before { visit signin_path }
    
    it { should have_selector('title', text: full_title('Sign In'))}
  end
  
  describe "sign in" do
    before { visit signin_path }
    
    describe "With invalid information" do
      before { click_button "Sign In" }
      
      it { should have_selector('title', text: full_title('Sign In')) }      
      it { should have_selector('div.alert.alert-error', text: 'Wrong') }
    end
    
    describe "With valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }
      
      it { should have_selector('title', text: user.name) }      
      it { should have_link('Users', href: users_path) }
      it { should have_link('Profile', href: user_path(user))}      
      it { should have_link('Sign Out', href: signout_path) }
      it { should_not have_link('Sign In', href: signin_path) }
      it { should have_link('Settings', href: edit_user_path(user)) }
      
      describe "when user signs out" do
        before { click_link "Sign Out" }
        it { should have_link("Sign In") }
      end
    end
  end
  
  describe "Authorization" do
    describe "for non-signed in users" do
      let(:user) { FactoryGirl.create(:user) }
      
      describe "in the users controller" do
        
        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_selector('title', text: 'Sign In') }        
        end
        
        describe "visiting the index page" do
          before { visit users_path }
          it { should have_selector('title', text: 'Sign In') }
        end
      
        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end
      end 
      
      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          sign_in user
        end
        
        describe "after signining in" do
          it "should render the desired protected page" do
            page.should have_selector('title', text: "Edit Profile")
          end
        end
      end   
    end
    
    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, username: "mr.wrong", email: "wrong@example.com") }
      before { sign_in user }
    
      describe "Visiting Users-> Edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should have_selector('title', text: full_title('')) }
      end
    
      describe "submitting a put request" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(root_path) }
      end
    end
  end
end
