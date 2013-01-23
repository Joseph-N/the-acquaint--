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
      before do
        fill_in "Email",    with: user.email
        fill_in "Password", with: user.password
        click_button "Sign In"
      end
      
      it { should have_selector('title', text: user.name) }
      it { should have_link('Sign Out', href: signout_path) }
      it { should_not have_link('Sign In', href: signin_path) }
      
      describe "when user signs out" do
        before { click_link "Sign Out" }
        it { should have_link("Sign In") }
      end
    end
  end
  
  describe "Authorisation" do
 
    
  end
end
