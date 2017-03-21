class MemesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :store_current_location
  before_action :track_pageview

  def index
    @memes = Meme.visible.order(views_count: :desc).page(params[:page])
  end

  def show
    @meme = Meme.visible.find_by(slug: params[:id])
    View.create meme: @meme, user: current_user
  end

  def new
    @meme = current_user.memes.new
  end

  def edit
    @meme = current_user.memes.find_by(slug: params[:id])
  end

  def create
    @meme = current_user.memes.new meme_params
    if @meme.save
      respond_to do |f|
        f.html { redirect_to meme_path(@meme.slug), notice: 'Meme launched!' }
        f.json { render 'show' }
      end
    else
      respond_to do |f|
        f.html { render 'new' }
        f.json { render 'show' }
      end
    end
  end

  def update
    @meme = current_user.memes.find_by(slug: params[:id])
    if @meme.update(meme_params)
      respond_to do |f|
        f.html { redirect_to meme_path(@meme.slug), notice: 'Meme updated.' }
        f.json { render 'show' }
      end
    else
      respond_to do |f|
        f.html { render 'edit' }
        f.json { render 'show' }
      end
    end
  end

  def destroy
    @meme = current_user.memes.find_by(slug: params[:id])
    @meme.destroy
    respond_to do |f|
      f.html { redirect_to memes_path, notice: 'Meme deleted.' }
      f.json { render json: { success: true } }
    end
  end

  def buy
    @meme = Meme.visible.find_by(slug: params[:meme_id])
    if @meme.buy(current_user)
      respond_to do |f|
        f.html { redirect_to meme_path(@meme.slug), notice: 'Shares bought!' }
        f.json { render json: { success: true } }
      end
    else
      respond_to do |f|
        f.html { redirect_to meme_path(@meme.slug), alert: 'Insufficient funds.' }
        f.json { render json: { success: false } }
      end
    end
  end

  def sell
    @meme = Meme.visible.find_by(slug: params[:meme_id])
    if @meme.sell(current_user)
      respond_to do |f|
        f.html { redirect_to meme_path(@meme.slug), notice: 'Shares sold!' }
        f.json { render json: { success: true } }
      end
    else
      respond_to do |f|
        f.html { redirect_to meme_path(@meme.slug), alert: 'No shares to sell.' }
        f.json { render json: { success: false } }
      end
    end
  end

  def report
    @meme = Meme.visible.find_by(slug: params[:meme_id])
    Report.create(meme: @meme, user: current_user, reason: params[:reason])
    respond_to do |f|
      f.html { redirect_to memes_path, notice: 'Meme reported.' }
      f.json { render json: { success: true } }
    end
  end

  private

  def meme_params
    params.require(:meme).permit(:title, :image, :slug)
  end

  def track_pageview
    Keen.publish_async 'pageviews', {
      url: request.original_url,
      ip:  request.remote_ip
    }
  end
end
