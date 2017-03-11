module ApplicationHelper
  def share_reddit_url(url)
    "http://www.reddit.com/submit?url=#{ CGI.escape url }"
  end
end
