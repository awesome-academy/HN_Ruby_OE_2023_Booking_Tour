require 'rails_helper'

RSpec.describe TourDetail, type: :model do
  describe "validations" do
    it{should validate_presence_of(:detail_description)}
    it{should validate_presence_of(:tour_detail_name)}
    it{should validate_presence_of(:start_location)}
    it{should validate_presence_of(:price)}
    it do
      should validate_numericality_of(:price)
        .is_greater_than_or_equal_to(Settings.price_min)
    end
    it{should validate_presence_of(:max_people)}
    it do
      should validate_numericality_of(:max_people)
        .is_greater_than_or_equal_to(Settings.peoples_booking_min)
    end
    it{should validate_presence_of(:time_duration)}
    it do
      should validate_numericality_of(:time_duration)
        .is_greater_than_or_equal_to(Settings.time_during_min)
    end
    it{should belong_to(:tour)}
  end
  describe "associations" do
    it{should have_many(:bookings).dependent(:destroy)}
    it{should have_many(:reviews).through(:bookings).source(:review)}
  end
  describe "create" do
    it "validate params " do
      tour_detail = build(:tour_detail)
      expect(tour_detail.save).to be true
    end
    it "invalidate parmas " do
      tour_detail = build(:tour_detail,tour_detail_name: "")
      expect(tour_detail.save).to be false
    end
  end
end
