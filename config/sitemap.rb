# Your website's host name
SitemapGenerator::Sitemap.default_host = "https://www.daqbut.com"

# The remote host where your sitemaps will be hosted
SitemapGenerator::Sitemap.sitemaps_host = "http://s3.amazonaws.com/bucketeer-6d80ff42-498d-4a23-8912-70ab34a78abd/"

# The directory to write sitemaps to locally
SitemapGenerator::Sitemap.public_path = 'tmp/'

# Set this to a directory/path if you don't want to upload to the root of your `sitemaps_host`
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

# Instance of `SitemapGenerator::WaveAdapter`
SitemapGenerator::Sitemap.adapter = SitemapGenerator::WaveAdapter.new

SitemapGenerator::Sitemap.create do
  add root_path, priority: 0.1, changefreq: 'annually'
  add memes_path, priority: 0.9, changefreq: 'daily'

  Meme.visible.find_each do |meme|
    add meme_path(meme.slug), priority: 0.5, changefreq: 'daily'
  end
end
