require 'spec_helper'

describe User, type: :model do
  it { have_many(:restaurant) }
  it { have_many(:review) }
end
