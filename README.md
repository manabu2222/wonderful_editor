# 概要

- WonderfulEditor（記事作成アプリ）
https://wonderful-editor-xobr.onrender.com

# デモ操作

- 操作の流れ（新規登録→記事作成→記事一覧表示→記事削除→ログアウト）

  ![portfolio](https://user-images.githubusercontent.com/59129419/224529496-392d1e38-c252-4070-9cd9-383f4883f766.gif)

# 動作環境

- ruby 2.7.1
- Rails 6.0.3.3
- Vue.js: 2.6.11
- DB: PostgreSQL

# 主な使用Gem

- active_model_serializers
- devise_token_auth
- rubocop-rails
- rubocop-rspec
- annotate
- pry-byebug
- pry-rails
- pry-doc

# 実装機能

- ユーザー登録・サインイン/サインアウト
- 記事一覧機能 （トップページ）
- 記事CRUD （一覧以外）
- 記事下書き機能
- マイページ機能 （自分が書いた記事の一覧）
- ゲストログイン機能

# 起動コマンド

```Shell
# API server
$ bundle exec rails s

# Client server
$ bin/webpack-dev-server
```
