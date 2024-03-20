require 'rails_helper'

RSpec.describe TourFollowing, type: :model do
  describe "associations" do
    it {should belong_to(:user)}
    it {should belong_to(:tour)}
  end
end
