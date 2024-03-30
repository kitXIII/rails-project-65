# frozen_string_literal: true

class Web::Admin::CategoriesController < Web::Admin::ApplicationController
  def index
    @categories = Category.order(updated_at: :desc)
    authorize Category
  end

  def new
    @category = Category.new
    authorize @category
  end

  def edit
    @category = Category.find params[:id]
    authorize @category
  end

  def create
    @category = Category.create(category_params)
    authorize @category

    if @category.save
      redirect_to admin_categories_path, notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @category = Category.find params[:id]
    authorize @category

    if @category.update(category_params)
      edirect_to admin_categories_path, notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find params[:id]
    authorize @category

    notification =
      if @category.destroy!
        {}
      else
        { alert: like.errors.full_messages.to_sentence }
      end

    redirect_to admin_categories_path, notification
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
