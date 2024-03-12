require 'rails_helper'

RSpec.describe User, type: :model do
  it "registratrion user valid " do
    user = FactoryBot.create(:user)
    expect(user.save).to be true
  end
end
