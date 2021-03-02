# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  body       :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe Article, type: :model do
  context "title を指定しているとき" do
    let(:article) { build(:article) }
    it "記事作成に成功する" do
      expect(article).to be_valid
    end
  end

  context "title を指定していないとき" do
    let(:article) { build(:article, title: nil) }
    it "記事作成に失敗する" do
      expect(article.valid?).to eq false
    end
  end
end
