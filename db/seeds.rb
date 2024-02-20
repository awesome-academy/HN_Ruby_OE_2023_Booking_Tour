
require 'faker'

5.times do
  User.create(
    username: Faker::Internet.username,
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.phone_number,
    image: Faker::LoremFlickr.image(size: '300x300', search_terms: ['user']),
    password: 'password', # Set a default password or use Faker::Internet.password
    admin: Faker::Boolean.boolean
  )
end

puts 'User seed data has been created!'

5.times do
  TourCategory.create(
    category_name: Faker::Lorem.word
  )
end


puts 'Tour and tour details seed data has been created!'
10.times do
  tour_category = TourCategory.order(Arel.sql('RAND()')).first
  tour = Tour.create(
    tour_name: Faker::Lorem.words(number: 3).join(' '),
    time_duration: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
    hagtag: Faker::Lorem.word,
    tour_description: Faker::Lorem.paragraph,
    tour_category: tour_category
  )

  # Create TourDetails
  #
  TourDetail.create(
    detail_description: Faker::Lorem.sentence,
    tour_detail_name: "#{tour.tour_name} Details",
    max_people: Faker::Number.between(from: 1, to: 20),
    start_location: Faker::Address.city,
    price: Faker::Number.decimal(l_digits: 3, r_digits: 2),
    tour: tour
  )
end

puts 'Tour seed data has been created!'

10.times do
  user = User.order(Arel.sql('RAND()')).first
  tour_detail = TourDetail.order(Arel.sql('RAND()')).first

  Booking.create(
    booking_date: Faker::Date.between(from: Date.today, to: 1.year.from_now),
    phone: Faker::PhoneNumber.phone_number,
    date_start: Faker::Date.between(from: Date.today, to: 1.month.from_now),
    end_date: Faker::Date.between(from: 1.month.from_now, to: 2.months.from_now),
    numbers_people: Faker::Number.between(from: 1, to: 10),
    total_amount: Faker::Number.decimal(l_digits: 3, r_digits: 2),
    status: Booking.statuses.values.sample, # Assumes you have an 'enum' for status
    tour_detail: tour_detail,
    user: user
  )
end

puts 'Booking seed data has been created!'
10.times do
  Review.create(
    review_text: Faker::Lorem.paragraph,
    user: User.all.sample,
    tour: Tour.all.sample
  )
end
puts 'Fake review data has been created!'

10.times do
  TourFollowing.create(
    tour: Tour.all.sample,
    user: User.all.sample
  )
end
puts 'TourFollowing seed data has been created!'
