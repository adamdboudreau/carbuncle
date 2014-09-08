require 'spec_helper'

describe User do
  describe "#valid?" do
    it "valid factory" do
      FactoryGirl.build(:user).valid?.should be_true
    end
  end

  describe ".similar_emails" do
    let(:user) { FactoryGirl.create(:user) }
    it "should return all users when given nil" do
      User.similar_emails(nil).should == [user]
    end

    it "should return users with the partial email given" do
      User.similar_emails("john").should == [user]
    end

    it "should not return users that don't match the partial given" do
      User.similar_emails("somebodygonnagetahurtrealbad").should be_empty
    end
  end

  # Commenting out the tests that are already covered by devise tests
  # it { should validate_presence_of :email }
  # %w{invalid_email_format 123 $$$ () ☃ bla@bla.}.each do |email|
  #   it { should_not allow_value(email).for(:email) }
  # end
  # it { should allow_value('a@b.c').for(:email) }
end