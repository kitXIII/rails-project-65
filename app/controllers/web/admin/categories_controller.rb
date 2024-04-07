# frozen_string_literal: true

class Web::Admin::CategoriesController < Web::Admin::ApplicationController
  before_action :set_category, only: %i[edit update destroy]

  def index
    @q = Category.order(name: :asc).ransack(params[:q])

    @categories = @q.result
  end

  def new
    @category = Category.new
  end

  def edit; end

  def create
    @category = Category.create(category_params)

    if @category.save
      redirect_to admin_categories_path, notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @category.destroy
      redirect_to admin_categories_path
    else
      redirect_to admin_categories_path, { alert: @category.errors.full_messages.to_sentence }
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find params[:id]
  end
end
