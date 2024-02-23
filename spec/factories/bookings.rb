require "faker"
FactoryBot.define do
  factory :booking do
    booking_date { Time.zone.now}
    phone { "84367673799" }
    date_start { Time.zone.now + 3.days }
    numbers_people { 3 }
    tour_detail { FactoryBot.create(:tour_detail) }
    user { FactoryBot.create(:user) }
    created_at {Time.zone.now}
    updated_at {Time.zone.now}
    factory :booking_canceled do
      after(:create) do |booking|
        booking.update(reason: "TEST")
        booking.canceled!
      end
    end
    factory :booking_future_pending do
      date_start {Time.zone.now + 1.day}
      after(:create) do |booking|
        booking.pending!
      end
    end
    factory :booking_past_confirmed do
      after(:create) do |booking|
        booking.confirmed!
        booking.update(date_start: 1.months.ago)
      end
    end
    factory :booking_pending do
      after(:create) do |booking|
        booking.pending!
      end
    end
    factory :booking_confirmed do
      after(:create) do |booking|
        booking.confirmed!
      end
    end
    factory :booking_success do
      after(:create) do |booking|
        booking.successed!
      end
    end
  end
end
