require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let(:user) { FactoryBot.create(:user) }
  describe "POST /signin", csrf: false do
    it "logs in with valid user" do
      post signin_path , params: {
        user: {
          email: user.email,
          password: "password"
        }
      }
      expect(response).to redirect_to(root_path)
      expect(response).to have_http_status(:see_other)
    end

    it "does not log in with invalid user" do
      post signin_path , params: {
        user: {
          password: 'wrong_password'
        }
      }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
  describe "POST /signup " do
    it "does not log in with invalid user" do
      post user_registration_path , params: {
        user: {
          email: user.email,
          password: 'wrong_password',
          password_confirmation: "wrong_password2"
        }
      }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
