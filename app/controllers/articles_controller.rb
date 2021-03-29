class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]

  def index
    @articles = Article.all.order('created_at DESC')
  end

  def new
    @article = Article.new
  end
  
  def create
    # render plain: params[:article].inspect
    @article = Article.new(article_params)
    # @article.user = User.first
    @article.user = current_user
    if @article.save
      flash[:success] = 'Article was successfully created'
      redirect_to article_path(@article)
    else
      render :new
    end
  end

  def edit
    # @article = Article.find(params[:id])
  end

  def update
    # @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:success] = 'Article was updated'
      redirect_to article_path(@article)
    else
      flash[:notice] = 'Article was not updated'
      render :edit
    end
  end

  def destroy
    # @article = Article.find(params[:id])
    @article.destroy
    flash[:success] = 'Article was deleted'
    redirect_to articles_path
  end

  def show
    # @article = Article.find(params[:id])
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end
end
