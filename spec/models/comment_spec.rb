require 'spec_helper'

describe Comment do
  
  let(:user) { FactoryGirl.create(:user) }
  before { @comment = user.comments.build(content: "Lorem Ipsum") }
  
  subject { @comment }
  
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:commenter_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }
  
  it { should be_valid }
  
  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Comment.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end
  
  describe "accessible attributes" do
    it "should not allow access to commenter_id" do
      expect do
        Comment.new(commenter_id: 1)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end
  
  describe "when user_id not present" do
    before { @comment.user_id = nil }
    it { should_not be_valid }    
  end
  
  describe "when commenter_id not present" do
    before { @comment.commenter_id = nil }
    it { should_not be_valid }
  end
  
end
