require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "validations" do
    it {should validate_presence_of(:review_text)}
    it {should belong_to(:booking)}
    it {should validate_uniqueness_of(:booking_id)}
  end
  describe "associations" do
    it {should have_one(:user).through(:booking).source(:user)}
  end
end
