require "rails_helper"

RSpec.describe "Api::V1::GuestSignIns", type: :request do
  describe "POST api/v1/guest_sign_ins" do
    subject { post(api_v1_guest_sign_ins_path) }

    context "正常系" do
      context "ゲストログインのリクエストが送られたとき" do
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

      context "ゲストログインのリクエストが二度送られたとき" do
        let(:user) { create(:user) }

        it "トークンが破棄されても、再びゲストログインのリクエストが送られれば、新たなトークンが付与される" do
          subject
          header = response.header
          expect(header["uid"]).to be_present
          expect(header["access-token"]).to be_present
          expect(header["client"]).to be_present
          # トークン破棄
          header.delete("uid")
          header.delete("access-token")
          header.delete("client")
          # 再リクエスト
          post "/api/v1/guest_sign_ins"
          header = response.header
          expect(header["uid"]).to be_present
          expect(header["access-token"]).to be_present
          expect(header["client"]).to be_present
        end
      end
    end
  end
end
