require 'spec_helper'

describe Painting do
  it { should validate_presence_of :title }
  it { should_not allow_value(-1).for(:ordinal) }
  it { should_not allow_value(0).for(:ordinal) }
  it { should allow_value(1).for(:ordinal) }
  it { should allow_value(nil).for(:ordinal) }
end