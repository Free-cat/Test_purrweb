class CategoryController < ApplicationController

  def create
    @category = Category.new(category_params)
    if @category.save
      render :json => {:result => 'ok', :category => @category}
    else
      render :json => {:result => 'error', :errors => @category.errors.messages }, :status => :bad_request
    end
  end

  def list
    @category = Category.all
    if @category.blank?
      render :json => {:result => 'error', :errors => 'Now there are no categories'}
    else
      render :json => {:result => 'ok', :categories => @category}
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
