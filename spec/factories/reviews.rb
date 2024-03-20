FactoryBot.define do
  factory :review do
    review_text {"Review"}
    booking {FactoryBot.create(:booking_success)}
  end
end
