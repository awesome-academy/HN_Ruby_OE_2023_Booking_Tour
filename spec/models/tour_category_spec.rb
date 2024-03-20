require 'rails_helper'

RSpec.describe TourCategory, type: :model do
  describe "validations" do
    it {should validate_presence_of(:category_name)}
  end
  describe "associations" do
    it {should have_many(:tours).dependent(:restrict_with_error)}
  end
  describe "Scope" do
    it "new_category"do
      tour_category1 = create(:tour_category)
      tour_category2 = create(:tour_category)
      expect(TourCategory.new_category).to eq([tour_category2, tour_category1])
    end
  end
end
