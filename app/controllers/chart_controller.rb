class ChartController < ApplicationController
  def show
    raise ActiveRecord::RecordNotFound if $redis.llen(params[:meme_id]) == 0
    data = $redis.lrange(params[:meme_id], -100, -1).map(&:to_i)
    g = Gruff::Line.new((params[:width] || 304).to_i, false)
    g.theme = {
      colors: %w(black white white white white),
      marker_color: 'white',
      font_color: 'gray',
      background_colors: %w(white white)
    }
    g.data 'Meme Price (DANK)', data
    send_data g.to_blob, type: 'image/png', disposition: 'inline'
  end
end
