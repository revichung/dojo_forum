class Admin::CategoriesController < Admin::BaseController
  before_action :set_category, only: [:update, :destroy]

  def index
    @categories = Category.all

    if params[:id]
      @category = Category.find(params[:id])
    else
      @category = Category.new
    end
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "category created"
      redirect_to admin_categories_path
    else
      flash[:alert] = @category.errors.full_messages.to_sentence
      redirect_to admin_categories_path
    end
  end

  def update
    #@category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to admin_categories_path
      flash[:notice] = "category updated"
    else
      flash[:alert] = @category.errors.full_messages.to_sentence
      redirect_to admin_categories_path
    end
  end

  def destroy
    #@category = Category.find(params[:id])
    if @category.destroy
      flash[:alert] = "category deleted"
      redirect_to admin_categories_path
    else
      flash[:alert] = @category.errors.full_messages.to_sentence
      redirect_to admin_categories_path
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
