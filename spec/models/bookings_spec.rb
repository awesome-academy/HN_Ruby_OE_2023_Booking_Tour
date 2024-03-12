require 'rails_helper'

RSpec.describe Booking, type: :model do
  it "Create new booking " do
    booking = FactoryBot.create(:booking)
    expect(booking.user_id).to be User.last.id
    expect(booking.tour_detail_id).to be TourDetail.last.id
    # expect(booking.save).to be true
  end
end
