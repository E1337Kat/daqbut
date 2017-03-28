class ChartsController < ApplicationController
  def show
    @meme = Meme.visible.find_by(slug: params[:meme_id])
  end
end
