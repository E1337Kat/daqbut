class ReportsController < ApplicationController
  def new
    @meme = Meme.visible.find_by(slug: params[:meme_id])
    @report = Report.new meme: @meme
  end

  def create
    @meme = Meme.visible.find_by(slug: params[:meme_id])
    Report.create(meme: @meme,
                  user: current_user,
                  reason: params[:report][:reason])
    respond_to do |f|
      f.html { redirect_to memes_path, notice: 'Meme reported.' }
      f.json { render json: { success: true } }
    end
  end
end
