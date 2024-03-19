class BookingUpdateJob
  include Sidekiq::Worker
  def perform
    Booking.overtimebooking.each do |booking|
      BookingStatusCancelJob.new.perform booking.id
    end

    Booking.successbooking.each do |booking|
      BookingStatusSuccessJob.new.perform booking.id
    end
  end
end
