class CategoriesController < ApplicationController
  def index
    @categories = current_user.categories
  end

  def new
    @category = Category.new
  end

  def create
    @categories = current_user.categories

    if @categories.create!(sanitized_params)
      render "index", status: 200
    else
      render "new"
    end
  end

  private

  def sanitized_params
    params.require(:category).permit(:name, :allotment, :period,
                                     :user_id, :start_date)
  end
end
