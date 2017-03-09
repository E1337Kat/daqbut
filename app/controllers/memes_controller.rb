class MemesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @memes = Meme.order(price: :desc)
  end

  def show
    @meme = Meme.find_by(slug: params[:id])
    @meme.increment!(:views)
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
        f.html { redirect_to meme_path(@meme.slug), notice: 'IPO launched!' }
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
        f.html { redirect_to meme_path(@meme.slug), notice: 'IPO successfully launched!' }
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
      f.html { redirect_to memes_path, notice: 'Meme successfully cashed out!' }
      f.json { render json: { success: true } }
    end
  end

  private

  def meme_params
    params.require(:meme).permit(:title, :image)
  end
end
