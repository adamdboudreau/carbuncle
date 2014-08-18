require 'spec_helper'
#require './app/models/user'

describe User do
  it { should validate_presence_of :email }
  # it { should validate_format_of :email, with: /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i }

  it { should_not allow_value('a@b').for(:email) }

  it { should allow_value('a@b.c').for(:email) }
  describe "#valid?" do
    it "valid factory" do
      FactoryGirl.build(:user).valid?.should be_true
    end
  end
end