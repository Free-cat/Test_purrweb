class AuthorController < ApplicationController

  def create
    @author = Author.new(author_params)
    if @author.save
      render :json => {:result => 'ok', :author => @author}
    else
      render :json => {:result => 'error', :errors => @author.errors.messages }, :status => :bad_request
    end
  end

  def list
    @authors = Author.all
    if @authors.blank?
      render :json => {:result => 'error', :errors => 'Now there are no authors'}
    else
      render :json => {:result => 'ok', :authors => @authors}
    end
  end

  def show
    @author = Author.find(params[:id])
    if @author.blank?
      render :json => { :result => 'error', :errors => "The author with id #{params[:id]} was not found" }, :status => :no_content
    else
      render :json => { :result => 'ok', :author => @author }
    end
  end

  def author_params
    params.require(:author).permit(:first_name, :last_name)
  end

end
