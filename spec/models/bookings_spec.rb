require 'rails_helper'

RSpec.describe Booking, type: :model do
  it "Create new booking " do
    booking = FactoryBot.create(:booking)
    expect(booking.save).to be true
  end
  it "new with date date start before now" do
    booking = FactoryBot.create(:booking, date_start: Time.zone.now - 1.days )
    expect(booking.save).to be false
  end
end
