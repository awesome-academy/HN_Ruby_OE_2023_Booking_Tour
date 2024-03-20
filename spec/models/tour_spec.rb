require 'rails_helper'

RSpec.describe Tour, type: :model do
  let!(:tour){create(:tour)}
  let!(:tour1){create(:tour)}
  describe "validatins" do
    it { should validate_presence_of(:tour_name) }
    it { should validate_presence_of(:image) }
  end

  describe "associations" do
    it { should belong_to(:tour_category)}
    it { should have_many(:bookings).through(:tour_details).source(:bookings) }
    it { should have_many(:tour_followings).dependent(:destroy) }
    it { should have_many(:followed_users).through(:tour_followings).source(:user) }
    it { should have_many(:reviews).through(:tour_details).source(:reviews) }
  end

  describe "scopes" do
    it "orders tour by creation date in descending order" do
      expect(Tour.new_tour).to eq([tour1, tour])
    end
  end
  describe "create" do
    it " new tour " do
      expect(tour.save).to be true
    end
  end
  describe "Update" do
    it "tour valid" do
      tour.update(tour_name: "new name")

      tour.reload

      expect(tour.tour_name).to eq("new name")
    end
  end

  describe "delete" do
    it "deletes a tour detail with no" do

      expect {
        tour.destroy
      }.to change { Tour.count }.by(-1)
    end
  end
end
