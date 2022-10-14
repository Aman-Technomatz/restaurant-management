class MenusController < ApplicationController
  def index
    @categories = Category.includes(:items)
  end
end
