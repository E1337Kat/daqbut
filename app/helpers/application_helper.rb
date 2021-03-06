module ApplicationHelper
  def share_reddit_url(url)
    "http://www.reddit.com/submit?url=#{ CGI.escape url }"
  end

  def render_markdown(text)
    return if text.blank?
    Kramdown::Document.new(text).to_html.html_safe
  end

  def chart_points(meme)
    raw_points = $redis.lrange(meme.slug, -100, -1).map(&:to_i)
    span = (raw_points.max - raw_points.min)
    return '' if span == 0
    point_strings = raw_points.map.with_index do |price, index|
      value = (price - raw_points.min) * 100.0 / span
      "#{index},#{100-value.round}"
    end
    point_strings.join(' ')
  end
end
