module ApplicationHelper
  def share_reddit_url(url)
    "http://www.reddit.com/submit?url=#{ CGI.escape url }"
  end

  def render_markdown(text)
    return if text.blank?
    Kramdown::Document.new(text).to_html.html_safe
  end
end
