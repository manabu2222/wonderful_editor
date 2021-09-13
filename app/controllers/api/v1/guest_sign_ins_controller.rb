module Api::V1
  class GuestSignInsController < BaseApiController

    # ゲストユーザー専用のメールアドレスが DB 内に登録されているか否かの確認
    # 登録されていないとき、メールアドレス（guest@example.com）パスワード（ランダム）で
    # ゲストユーザー生成
    def create
      user = User.find_or_create_by!(name: 'guest',email: 'guest@example.com') do |user|
        user.password = SecureRandom.urlsafe_base64
      end
      tokens = user.create_new_auth_token
      headers["access-token"] = tokens["access-token"]
      headers["uid"] = tokens["uid"]
      headers["client"] = tokens["client"]
    end
  end
end
