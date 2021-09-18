require "rails_helper"

RSpec.describe "Api::V1::GuestSignIns", type: :request do
  describe "POST api/v1/guest_sign_ins" do
    subject { post(api_v1_guest_sign_ins_path) }

    context "正常系" do
      context "ゲストログインボタンが押下されたとき" do
        let(:user) { create(:user) }

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
      context "ゲストログインボタンが押下されたとき" do
        it "予期せぬ影響でトークンが破棄されたら、ログイン時に行えていた動作ができなくなる" do
          subject
          header = response.header
          # トークン破棄
          header.delete("uid")
          header.delete("access-token")
          header.delete("client")
          expect(header["uid"]).to be_blank
          expect(header["access-token"]).to be_blank
          expect(header["client"]).to be_blank
          expect(response).to have_http_status(204)
        end
      end
    end
  end
end
