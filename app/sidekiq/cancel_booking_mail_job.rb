class CancelBookingMailJob
  include Sidekiq::Job

  def perform booking_id
    booking = Booking.find booking_id
    return if booking

    BookingMailer.with(booking.user, booking)
                 .cancel_booking.deliver_later
  end
end
