require 'spec_helper'

describe "StaticPages" do
  subject { page }
  
  shared_examples_for "all static pages" do
    it{ should have_selector('h1', text: heading) }
    it{ should have_selector('title', text:full_title(page_title)) }
  end
  
  describe "About Page" do
    before { visit about_path }
    let(:heading) { 'About The Acquiant' }
    let(:page_title) { 'About'}    
    it_should_behave_like "all static pages"
     
    it "Should link to the correct page" do
      visit root_path
      click_link "Sign Up"
      page.should have_selector('title', text: full_title('Sign Up'))
      
      click_link "About"
      page.should have_selector('title', text: full_title('About'))
    end
  end
end
