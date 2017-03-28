class SharesController < ApplicationController
  before_action :authenticate_user!

  def new_buy
    @meme = Meme.visible.find_by(slug: params[:meme_id])
    if @meme.price > current_user.points
      redirect_to meme_path(@meme.slug), alert: 'Insufficient funds.'
    end
  end

  def new_sell
    @meme = Meme.visible.find_by(slug: params[:meme_id])
    if @meme.share_count(current_user) < 1
      redirect_to meme_path(@meme.slug), alert: 'No shares to sell.'
    end
  end

  def buy
    @meme = Meme.visible.find_by(slug: params[:meme_id])
    if @meme.buy(current_user, params[:quantity].to_i)
      redirect_to meme_path(@meme.slug), notice: 'Shares bought!'
    else
      redirect_to meme_buy_path(@meme.slug), alert: 'Insufficient funds.'
    end
  end

  def sell
    @meme = Meme.visible.find_by(slug: params[:meme_id])
    if @meme.sell(current_user, params[:quantity].to_i)
      redirect_to meme_path(@meme.slug), notice: 'Shares sold!'
    else
      redirect_to meme_sell_path(@meme.slug), alert: 'No shares to sell.'
    end
  end
end
