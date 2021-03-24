module Api::V1
  # base_api_controller を継承
  class ArticlesController < BaseApiController
    def create
      article = current_user.articles.create!(article_params)
      render json: article, serializer: Api::V1::ArticleSerializer
    end

    def show
      article = Article.find(params[:id])
      render json: article, serializer: Api::V1::ArticleSerializer
    end

    def index
      articles = Article.order(updated_at: :desc)
      render json: articles, each_serializer: Api::V1::ArticlePreviewSerializer
    end

    def update
      article = current_user.articles.find(params[:id])
      article.update!(article_params)
      render json: article, serializer: Api::V1::ArticleSerializer
    end

    private

      # ストロングパラメータでpermitに渡された値以外を受け取らないようにする
      def article_params
        params.require(:article).permit(:title, :body)
      end
  end
end
