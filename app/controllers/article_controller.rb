class ArticleController < ApplicationController

  def create
    @article = Article.new(article_params)

    if params[:article].has_key?('tag')
      @article.tags << Tag.create(tag_params(params[:article][:tag]))
    else
      if params[:article].has_key?('tags')
        params[:article][:tags].each do |tag|
          if tag['name'] != ""
            @article.tags << Tag.create(tag_params(tag))
          end
        end
      end
    end

    if @article.save
      render :json => { :result => 'ok',
                        :article => @article.to_json(:include =>
                                                         {:tags =>
                                                              {:only => [:name]}
                                                         })}
    else
      render :json => { :result => 'error', :errors => @article.errors.messages }, :status => :bad_request
    end
  end

  def by_author
    @articles = Article.by_author(params[:author_id])
    if @articles.blank?
      render :json => {:result => 'error', :errors => 'Article not found'}, :status => :no_content
    else
      render :json => {:result => 'ok',
                       :articles => @articles.to_json(:include =>
                                                          {:tags =>
                                                               {:only => [:name]}
                                                          })}
    end
  end

  def by_tag
    @articles = Article.by_tag(params[:tag_name])
    if @articles.blank?
      render :json => {:result => 'error', :errors => 'Article not found'}, :status => :no_content
    else
      render :json => {:result => 'ok',
                       :articles => @articles.to_json(:include => {:tags => {:only => [:name]}
                                                          })}
    end
  end

  def today
    @articles = Article.today
    if @articles.blank?
      render :json => {:result => 'error', :errors => 'Article not found'}, :status => :no_content
    else
      render :json => {:result => 'ok',
                       :articles => @articles.to_json(:include =>
                                                          {:tags =>
                                                               {:only => [:name]}
                                                          })}
    end
  end

  def by_category
    @articles = Article.by_category(params[:category_id])
    if @articles.blank?
      render :json => {:result => 'error', :errors => 'Article not found'}, :status => :no_content
    else
      render :json => {:result => 'ok',
                       :articles => @articles.to_json(:include =>
                                                          {:tags =>
                                                               {:only => [:name]}
                                                          })}
    end
  end

  def show
    @articles = Article.find(params[:id])
    if @articles.blank?
      render :json => { :result => 'error', :errors => "The article with id #{params[:id]} was not found" }, :status => :no_content
    else
      render :json => {:result => 'ok',
                       :articles => @articles.to_json(:include =>
                                                          {:tags =>
                                                               {:only => [:name]}
                                                          })}
    end
  end

  private

  def article_params
    params.require(:article).permit(:author_id, :category_id, :name, :summary, :content)
  end

  def tag_params(my_params)
    my_params.permit(:name)
  end
end
