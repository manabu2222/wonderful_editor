module Api::V1
  # base_api_controller を継承
  class ArticlesController < BaseApiController
    def new
      #空のArticleオブジェクトを生成
      @article = Article.new
    end

    def create
      @article = Article.new(article_params)
      if @article.save
        redirect_to @article #@articleはarticle_path(@article)と同義
      else
        #エラー時は再度、記事登録画面を表示させる
        render :new
      end
    end

    def show
      article = Article.find(params[:id])
      render json: article, serializer: Api::V1::ArticleSerializer
    end

    def index
      articles = Article.order(updated_at: :desc)
      render json: articles, each_serializer: Api::V1::ArticlePreviewSerializer
    end

    private
    #ストロングパラメータでpermitに渡された値以外を受け取らないようにする
    def article_params
      params.require(:article).permit(:title,:body)
    end
  end
end
