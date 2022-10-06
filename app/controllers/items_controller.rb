class ItemsController < ApplicationController
  before_action :set_category, only: [:create, :show, :edit, :update, :destroy]
  before_action :set_item, only: [:edit, :destroy, :update]

  def create
    @item = @category.items.create(item_params)
    redirect_to category_path(@category)
  end

  def edit

  end

  def update
    if @item.update(item_params)
      redirect_to category_url(@category)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to @category, status: :see_other
  end

  private
    def set_category
      @category = Category.find(params[:category_id])
    end

    def set_item
      @item = @category.items.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:name, :image, portions: [:single, :double, :triple])
    end
end
