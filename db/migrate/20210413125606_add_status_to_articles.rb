class AddStatusToArticles < ActiveRecord::Migration[6.0]
  #変更内容
  def up
    add_column :articles, :status, :string, default: "draft"
  end

  #変更前の状態
  def down
    add_column :articles, :status, :int, default: "draft"
  end
end
