class MemesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :store_current_location

  def index
    @memes = Meme.visible.order(created_at: :desc).page(params[:page])
  end

  def profile
    @memes = current_user.memes.visible.order(created_at: :desc).page(params[:page])
  end

  def show
    @meme = Meme.visible.find_by(slug: params[:id])
    @derivatives = Meme.visible.where(parent: @meme).page(params[:page])
  end

  def new
    @parent = Meme.find_by(slug: params[:parent_id]) if params[:parent_id]
    @meme = current_user.memes.new(parent: @parent)
  end

  def edit
    @meme = current_user.memes.find_by(slug: params[:id])
  end

  def create
    meme_params = params.require(:meme).permit(:title,
                                               :image,
                                               :slug,
                                               :description,
                                               :parent_id,
                                               :anonymous)
    @meme = current_user.memes.new meme_params
    if current_user.points < @meme.fee
      redirect_to memes_path, notice: 'Insufficient funds.'
    elsif @meme.save
      current_user.increment!(:points, -@meme.fee)
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
    meme_params = params.require(:meme).permit(:title,
                                               :slug,
                                               :description,
                                               :anonymous)
    @meme = current_user.memes.find_by(slug: params[:id])
    if @meme.update meme_params
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
end
