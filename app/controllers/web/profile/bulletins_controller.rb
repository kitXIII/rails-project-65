# frozen_string_literal: true

class Web::Profile::BulletinsController < Web::Profile::ApplicationController
  def new
    @bulletin = Bulletin.new
    authorize @bulletin
  end

  def edit
    @bulletin = current_user.bulletins.find params[:id]
    authorize @bulletin
  end

  def create
    @bulletin = current_user.bulletins.build(bulletin_params)
    authorize @bulletin

    if @bulletin.save
      redirect_to @bulletin, notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @bulletin = current_user.bulletins.find params[:id]
    authorize @bulletin

    if @bulletin.update(bulletin_params)
      redirect_to @bulletin, notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :category_id, :image)
  end
end
