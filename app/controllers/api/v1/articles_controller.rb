module Api::V1
  # base_api_controller を継承
  class ArticlesController < BaseApiController
    # current_userでユーザー情報を取得できる
    before_action :authenticate_user!, only: [:create, :update, :destroy]

    def create
      article = current_user.articles.create!(article_params)
      render json: article, serializer: Api::V1::ArticleSerializer
    end

    def show
      article = Article.find(params[:id])

      if article.nil?
        redirect_to action: "index"
      elsif article.draft?
        require_login and return
      end

      render json: article, serializer: Api::V1::ArticleSerializer
    end

    def index
      articles = Article.published.order(updated_at: :desc)
      render json: articles, each_serializer: Api::V1::ArticlePreviewSerializer
    end

    def update
      article = current_user.articles.find(params[:id])
      article.update!(article_params)
      render json: article, serializer: Api::V1::ArticleSerializer
    end

    def destroy
      article = current_user.articles.find(params[:id])
      article.destroy!
    end

    private

      # ストロングパラメータでpermitに渡された値以外を受け取らないようにする
      def article_params
        params.require(:article).permit(:title, :body, :status)
      end

      def require_login
        redirect_to sign_in_path unless logged_in?
      end

      def logged_in?
        !current_user.nil?
      end
  end
end
