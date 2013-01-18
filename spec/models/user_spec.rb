# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do
  before do
    @user = User.new(name: "Joseph", email: "jojoartz@yahoo.com",
                           password: "password", password_confirmation: "password") 
  end
  
  subject { @user }
  
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation)}
  it { should respond_to(:authenticate) }
  
  it { should be_valid }
  
  describe "When name not present" do
    before { @user.name = "" }
    it { should_not be_valid }
  end
  
  describe "When email not present" do
    before { @user.email = "" }
    it { should_not be_valid }
  end
  
  describe "When naem is too long" do
    before { @user.name = "a" * 21 }
    it { should_not be_valid }
  end
  
  describe "When email format is invalid" do
    it "should be invalid" do
      invalid_addresses = %w[user@foo,com user_at_foo.org example.user@foo.foo@bar_z.com foo@bar+baz.com]
      for x in invalid_addresses do
        @user.email = x
        @user.should_not be_valid
      end
    end
  end
  
  describe "When email format is valid" do
    it "should be valid" do
      valid_addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      for x in valid_addresses do
        @user.email = x
        @user.should be_valid
      end
    end
  end
  
  describe "When email address is already taken" do
    before do
      user_with_exact_email = @user.dup
      user_with_exact_email.email = @user.email.upcase
      user_with_exact_email.save
    end
    
    it { should_not be_valid }
  end
  
  describe "When password is not present" do
    before { @user.password = @user.password_confirmation = "" }
    it { should_not be_valid }
  end
  
  describe "When password doesn't match confirmation" do
    before { @user.password_confirmation = "xxxxxx" }
    it { should_not be_valid }
  end
  
  describe "When password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end
  
  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end
  
end
