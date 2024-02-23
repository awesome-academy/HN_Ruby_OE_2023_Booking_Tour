module ReviewsHelper
  def reviewable? booking
    !booking&.review && booking.successed? &&
      (booking.user == current_user) &&
      Time.zone.now > booking.end_date
  end
end
