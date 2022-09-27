class MenusController < ApplicationController
  def index
    @categories = Category.all
  end
end
