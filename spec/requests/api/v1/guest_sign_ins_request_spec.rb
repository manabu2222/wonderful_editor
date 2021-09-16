require "rails_helper"

RSpec.describe "Api::V1::GuestSignIns", type: :request do
  describe "POST api/v1/guest_sign_ins" do
    subject { post(api_v1_guest_sign_ins_path, params: params) }

    context "正常系" do
      context "ゲストログインボタンが押下されたとき" do
        let(:user) { create(:user) }
        let(:params) { user.create_new_auth_token }

        it "ゲストログインに成功する" do
          subject
          header = response.header
          expect(header["uid"]).to be_present
          expect(header["access-token"]).to be_present
          expect(header["client"]).to be_present
          expect(response).to have_http_status(:no_content)
        end
      end
    end

    context "異常系" do
      context "ゲストログイン時、誤った情報が送られたとき" do
        let(:user) { create(:user) }
        let(:params) { { email: "", password: "password" } }

        it "ゲストログインできない" do
          subject

          # ここから
          # この間に、トークン情報を破棄する何かを追加する
          # ここまで

          # expect(response).to have_http_status(:ok)
          # expect(response).to have_http_status(204)
        end
      end
    end
  end
end
