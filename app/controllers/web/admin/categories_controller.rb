# frozen_string_literal: true

class Web::Admin::CategoriesController < Web::Admin::ApplicationController
  def index
    @q = Category.ransack(params[:q])
    @q.sorts = 'name asc' if @q.sorts.empty?

    @categories = @q.result
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find params[:id]
  end

  def create
    @category = Category.create(category_params)

    if @category.save
      redirect_to admin_categories_path, notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @category = Category.find params[:id]

    if @category.update(category_params)
      redirect_to admin_categories_path, notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find params[:id]

    notification =
      if @category.destroy
        {}
      else
        { alert: @category.errors.full_messages.to_sentence }
      end

    redirect_to admin_categories_path, notification
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
