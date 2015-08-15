class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new color: "#73defc"
  end

  def create
    @category = Category.new category_params
    if @category.save
      redirect_to category_path(@category)
    else
      render 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to @category
    else
      render 'edit'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    redirect_to categories_path
  end

  def show
    @category = Category.find params[:id]
  end

  private
    def category_params
      params.require(:category).permit(:color, :name)
    end
end
