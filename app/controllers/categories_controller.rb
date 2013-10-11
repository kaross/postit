class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]

  def index
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to @category, notice: 'Category was created!'
    else
      render 'new'
    end
  end

  def new
    @category = Category.new
  end

  def show

  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end

end
