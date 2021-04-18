# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  body       :text
#  status     :string           default("draft")
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

  context "記事を公開状態にしたとき" do
    let(:article) { build(:article, :published) }
    it "記事を公開状態で作成できる" do
      expect(article.status).to eq "published"
    end
  end

  context "記事を下書き状態にしたとき" do
    let(:article) { build(:article, :draft) }
    it "記事を下書き状態で作成できる" do
      expect(article.status).to eq "draft"
    end
  end
end
