require 'spec_helper'

describe Volunteer::Registration do
  it { should belong_to :profile }
  it { should belong_to :event }

  it { should validate_presence_of :event }
end
