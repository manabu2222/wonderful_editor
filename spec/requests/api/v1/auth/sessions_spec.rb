require "rails_helper"

RSpec.describe "Api::V1::Auth::Sessions", type: :request do
  describe "POST api/v1/auth/sign_in" do
    subject { post(api_v1_user_session_path, params: params) }

    context "正常系" do
      context "ログインに必要な値が送られたとき" do
        let(:user) { create(:user) }
        let(:params) { { email: user.email, password: user.password } }

        it "ログインに成功する" do
          subject
          header = response.header
          expect(header["uid"]).to be_present
          expect(header["access-token"]).to be_present
          expect(header["client"]).to be_present
          expect(response).to have_http_status(:ok)
        end
      end
    end

    context "異常系" do
      context "メールアドレスが正しくないとき" do
        let(:user) { create(:user) }
        let(:params) { { email: "test@example.com", password: user.password } }
        it "ログインできない" do
          subject
          res = JSON.parse(response.body)
          expect(res["success"]).to be_falsey
          expect(res["errors"]).to include("Invalid login credentials. Please try again.")
          expect(response.headers["uid"]).to be_blank
          expect(response.headers["access-token"]).to be_blank
          expect(response.headers["client"]).to be_blank
          expect(response).to have_http_status(:unauthorized)
        end
      end

      context "パスワードが正しくないとき" do
        let(:user) { create(:user) }
        let(:params) { { email: user.email, password: "password" } }
        it "ログインできない" do
          subject
          res = JSON.parse(response.body)
          expect(res["success"]).to be_falsey
          expect(res["errors"]).to include("Invalid login credentials. Please try again.")
          expect(response.headers["uid"]).to be_blank
          expect(response.headers["access-token"]).to be_blank
          expect(response.headers["client"]).to be_blank
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end

  # ーーーーーーーーーーーーコメント部分については、後ほど実装を行う予定ーーーーーーーーーーーー
  #
  # describe "POST api/v1/auth/guest_sign_in" do
  #   subject { post(api_v1_user_session_path, params: params) }
  #
  #   context "正常系" do
  #     context "ゲストログインボタンが押下されたとき" do
  #       it "ログインに成功する" do
  #
  #       end
  #     end
  #   end
  #
  #   context "異常系" do
  #
  #   end
  #
  # end
  #
  # ーーーーーーーーーーーーコメント部分については、後ほど実装を行う予定ーーーーーーーーーーーー

  describe "DELETE api/v1/auth/sign_out" do
    subject { delete(destroy_api_v1_user_session_path, headers: headers) }

    context "正常系" do
      context "ログアウトしたとき" do
        let(:user) { create(:user) }
        let(:headers) { user.create_new_auth_token }
        it "トークン情報が消え、ログアウトされる" do
          subject
          expect(user.reload.tokens).to be_blank
          expect(response).to have_http_status(:ok)
        end
      end
    end

    context "異常系" do
      context "誤った情報が送られたとき" do
        let(:user) { create(:user) }
        let(:headers) { { "access-token" => "", "token-type" => "", "client" => "", "expiry" => "", "uid" => "" } }

        it "ログアウトできない" do
          subject
          expect(response).to have_http_status(:not_found)
          res = JSON.parse(response.body)
          expect(res["errors"]).to include "User was not found or was not logged in."
        end
      end
    end
  end
end
