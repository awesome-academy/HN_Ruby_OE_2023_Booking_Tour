# Create Users
5.times do
  User.create!(
    username: Faker::Internet.username,
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.phone_number,
    image: Faker::LoremFlickr.image(size: '300x300', search_terms: ['user']),
    admin: Faker::Boolean.boolean
  )
end

puts 'User seed data has been created!'

# Create Categories
5.times do
  Category.create!(
    name: Faker::Lorem.word
  )
end

# Create Tours
10.times do
  tour_category = Category.order(Arel.sql('RAND()')).first

  Tour.create!(
    name: Faker::Lorem.words(number: 3).join(' '),
    time_duration: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
    hagtag: Faker::Lorem.word,
    description: Faker::Lorem.paragraph,
    category: tour_category
  )
end

# Follow Tours
Tour.all.each do |tour|
  User.first.follow_tour(tour)
end

# Create Tour Details
Tour.all.each do |tour|
  10.times do
    TourDetail.create!(
      description: Faker::Lorem.sentence,
      name: "#{tour.name} Details",
      max_people: Faker::Number.between(from: 1, to: 20),
      start_location: Faker::Address.city,
      price: Faker::Number.decimal(l_digits: 3, r_digits: 2),
      tour: tour
    )
  end
end

# Function to generate fake image URLs
def fake_image_url(width: 300, height: 200)
  "https://via.placeholder.com/#{width}x#{height}"
end

# Create Image Tours
20.times do
  ImageTour.create!(
    image_url: fake_image_url,
    tour: Tour.all.sample
  )
end

# Create Bookings
rand(1..3).times do
  Booking.create!(
    booking_date: Faker::Date.forward(days: 30),
    phone: Faker::PhoneNumber.phone_number,
    start_date: Faker::Date.forward(days: 30),
    end_date: Faker::Date.forward(days: 60),
    numbers_people: rand(1..5),
    total_amount: Faker::Number.decimal(l_digits: 3, r_digits: 2),
    user: User.all.sample,
    tour_detail: TourDetail.all.sample
  )
end

# Create Reviews
rand(1..12).times do
  Review.create!(
    content: Faker::Lorem.paragraph,
    user: User.all.sample,
    tour: Tour.all.sample
  )
end

# Create Image Reviews
rand(1..34).times do
  ImageReview.create!(
    image_url: fake_image_url,
    review: Review.all.sample
  )
end
