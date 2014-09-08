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

  describe ".ordered_by" do
    let(:users) do
      u1 = u2 = nil

      Timecop.freeze(2008, 7, 1, 12, 0, 0) do
        u1 = FactoryGirl.create(:user)
      end

      Timecop.freeze(2008, 7, 1, 12, 30, 0) do
        u2 = FactoryGirl.create(:user)
      end
      u3 = FactoryGirl.create(:user)
      
      [u1, u2, u3]
    end

    let(:alpha_users) do
      [FactoryGirl.create(:user, email: 'asdf@test.com'), FactoryGirl.create(:user, email: 'fdsa@test.com'), FactoryGirl.create(:user, email: 'fdsa@zest.com')]
    end

    context "email" do
      it "should sort by user emails" do
        User.ordered_by(:email, :asc).should == alpha_users
      end
      # it "should sort by user emails desc" do
      #   User.ordered_by(:email, :desc).should == alpha_users.reverse
      # end
    end

    context "created" do
      it "should sort by created time" do
        User.ordered_by(:created, :asc).should == users
      end
      # it "should sort by created time desc" do
      #   User.ordered_by(:created, :desc).should == users.reverse
      # end
    end
    
    context "updated" do
      it "should sort by updated time" do
        User.ordered_by(:updated, :asc).should == users
      end
      # it "should sort by updated time desc" do
      #   User.ordered_by(:updated, :desc).should == users.reverse
      # end
    end
  end

  # Commenting out the tests that are already covered by devise tests
  # it { should validate_presence_of :email }
  # %w{invalid_email_format 123 $$$ () ☃ bla@bla.}.each do |email|
  #   it { should_not allow_value(email).for(:email) }
  # end
  # it { should allow_value('a@b.c').for(:email) }
end