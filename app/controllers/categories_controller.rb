class CategoriesController < ApplicationController
  before_filter :authenticate_user!

  def categories

  end

  def destroy
    @ccount=current_user.incexp.find_by(categoty_id: params[:id])
    if !@ccount.nil?
      flash[:error] = "Error: category is'nt empty"
      redirect_to categories_path
    else
      @category = current_user.category.find(params[:id])
      @category.destroy ? flash[:success] = "category deleted!" : flash[:error] = "ERROR!"
      redirect_to categories_path
    end
  end

  def index
    @category = current_user.category.all
  end


  def new
    @category = Category.new
  end

  def edit
    @category = current_user.category.find(params[:id])
  end

  def update
    @categ = Category.find(params[:id])
    @categ.update(category_params) ? flash[:success] = "category update!" : flash[:error] = "ERROR!"
    redirect_to categories_path
  end

  def create
    @category= current_user.category.build(category_params_wtype)
    if @category.save
      flash[:success] = "category created!"
      redirect_to categories_path
    else
      flash[:error] = "ERROR!"
      redirect_to categories_path
    end
  end

  def category_params_wtype
    params.require(:category).permit(:name, :typef)
  end

  def category_params
    params.require(:category).permit(:name)
  end


end
