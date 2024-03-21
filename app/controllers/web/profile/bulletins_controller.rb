# frozen_string_literal: true

class Web::Profile::BulletinsController < Web::Profile::ApplicationController
  def new
    @bulletin = Bulletin.new
  end

  def edit; end

  def create
    @bulletin = current_user.bulletins.build(bulletin_params)

    if @bulletin.save
      redirect_to @bulletin, notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update; end

  private

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :category_id, :image)
  end
end
