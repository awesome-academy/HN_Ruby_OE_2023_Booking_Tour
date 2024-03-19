require 'rails_helper'

RSpec.describe Booking, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:date_start).on(:create).allow_nil }
    it { should validate_presence_of(:numbers_people) }
    it { should belong_to(:tour_detail) }
    it { should belong_to(:user) }
    let(:tour_detail) { create(:tour_detail, max_people: 10) }
    context 'when status is cancelled' do
      it 'validates presence of reason' do
        booking = build(:booking, status: :canceled)
        expect(booking).to validate_presence_of(:reason).on(:update)
      end
    end
    context 'custom validation: out_of_peoples' do
      it 'is valid when numbers_people is less than or equal to tour_detail max_people' do
        booking = build(:booking, tour_detail: tour_detail, numbers_people: 0)
        expect(booking).not_to be_valid
      end

      it 'is valid when numbers_people is less than or equal to tour_detail max_people' do
        booking = build(:booking, tour_detail: tour_detail, numbers_people: 8)
        expect(booking).to be_valid
      end

      it 'is invalid when numbers_people is greater than tour_detail max_people' do
        booking = build(:booking, tour_detail: tour_detail, numbers_people: 12)
        expect(booking).not_to be_valid
        expect(booking.errors[:numbers_people]).to include(I18n.t("bookings.errors.out_of_people", max_people: tour_detail.max_people))
      end
    end

    context 'custom validation: booking_date_in_future' do
      it 'is valid when date_start is in the future' do
        booking = build(:booking, date_start: Time.zone.now + 1.day)
        expect(booking).to be_valid
      end

      it 'is invalid when date_start is in the past' do
        booking = build(:booking, date_start: Time.zone.now - 1.day)
        expect(booking).not_to be_valid
        expect(booking.errors[:date_start]).to include(I18n.t("bookings.errors.date_in_fulture"))
      end
    end
    context 'when status is not cancelled' do
      it 'does not validate presence of reason' do
        booking = build(:booking, status: :pending)
        expect(booking).not_to validate_presence_of(:reason).on(:update)
      end
    end
  end
  describe 'Associations' do
    it { should have_one(:review).dependent(:destroy) }
  end
  describe 'Funcions ' do
    let(:booking_reason){{
      "reason" => "Cancel test"
      }
    }
    let(:booking_canceled) {create (:booking_canceled)}
    let(:future_pending_booking) { create(:booking_future_pending) }
    let(:past_confirmed_booking) { create(:booking_past_confirmed)}
    let(:booking_pending) { create(:booking_pending) }
    let(:booking_confirmed) { create(:booking_confirmed)}

    describe "#Create Booking " do
      it "Create new booking valid" do
        booking = create(:booking)
        expect(booking.save).to be true
      end

      it "new with date date start before now" do
        booking = build(:booking, date_start: Time.zone.now - 1.day)
        expect(booking.save).to be false
      end

      it "new with over people " do
        booking = create(:booking)
        booking.numbers_people = booking.tour_detail.max_people + 1
        expect(booking.save).to be false
      end
    end

    describe "#cancel_booking" do
      let(:booking) { create(:booking) }
      context "when booking is pending" do
        it "cancels the booking and sends cancel email" do
          expect { booking.cancel_booking booking_reason }.to change { booking.reload.status.to_sym }.to(:canceled)
        end
      end

      context "when booking is not pending" do
        before { booking.confirmed! }

        it "raises an error and does not cancel the booking" do
          expect { booking.cancel_booking booking_reason }.to raise_error(RuntimeError)
          expect(booking.reload.status.to_sym).not_to eq(:canceled)
        end
      end
    end

    describe "#confirm_booking" do
    context "when booking is pending" do
      let(:booking) { create(:booking) }
      it "confirms the booking and sends confirm email" do
          expect { booking.confirm_booking }.to change { booking.reload.status.to_sym }.to(:confirmed)
        end
      end

      context "when booking is not pending" do
        it "does not confirm the booking" do
          expect { booking_canceled.confirm_booking }.to raise_error(RuntimeError)
          expect(booking_canceled.status.to_sym).not_to eq(:confirmed)
        end
      end
    end

    describe "#successed_booking" do
      let(:booking) { create(:booking) }
      it "updates the booking status to successed and sends success email" do
        booking.confirmed!
        expect { booking.successed_booking }.to change { booking.status.to_sym }.to(:successed)
      end
    end

    describe "overtime_booking" do
      it "returns pending bookings with date_start >= now" do
        expect(Booking.overtime_booking).to include(future_pending_booking)
        expect(Booking.overtime_booking).not_to include(past_confirmed_booking)
      end
    end

    describe "success_booking" do
      it "returns confirmed bookings with end_date <= 3 days ago" do
        expect(Booking.success_booking).to include(past_confirmed_booking)
        expect(Booking.success_booking).not_to include(future_pending_booking)
      end
    end
  end
  describe 'Scope' do
    let!(:tour_detail1) { create(:tour_detail, max_people: 5, price: 100) }
    let!(:tour_detail2) { create(:tour_detail, max_people: 5, price: 100) }
    describe '.incomes' do
      it 'returns total amount grouped by day for successful bookings within the specified date range' do
        create(:booking_success, tour_detail: tour_detail1, created_at: Time.zone.now, numbers_people: 1)
        create(:booking_success, tour_detail: tour_detail2, created_at: 1.days.ago + 1.hour,  numbers_people: 1)

        result = Booking.incomes(1.days.ago, Time.zone.now)

        expect(result).to eq({ 1.days.ago.strftime(Settings.dd_mm_yyyy_fm) => 100, Time.zone.now.strftime(Settings.dd_mm_yyyy_fm) => 100 })
      end
    end

    describe '.new_bookings' do
      it 'returns count of new bookings grouped by tour detail within the specified date range' do
        create(:booking, tour_detail: tour_detail1, numbers_people: 1, created_at: Time.zone.now)
        create(:booking, tour_detail: tour_detail2, numbers_people: 1, created_at: 1.days.ago + 1.hour)
        create(:booking, tour_detail: tour_detail1, numbers_people: 1, created_at: Time.zone.now)
        result = Booking.new_bookings(1.days.ago, Time.zone.now)
        expect(result).to eq({ tour_detail1 => 2, tour_detail2 => 1})
        #
      end
    end

    describe '.status_bookings' do
      it 'returns count of bookings grouped by status within the specified date range' do
        create(:booking_pending, created_at: Time.zone.now)
        create(:booking_confirmed, created_at: Time.zone.now)
        create(:booking_success, created_at: Time.zone.now)

        result = Booking.status_bookings(1.days.ago, Time.zone.now)

        expect(result).to eq({ 'pending' => 1, 'confirmed' =>  1, 'successed' =>  1})
      end
    end

  end
end
