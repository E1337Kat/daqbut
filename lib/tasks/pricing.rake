namespace :pricing do
  desc "Update all meme prices"
  task update: :environment do
    Meme.find_each do |meme|
      new_price = meme.price + rand(100) - 50
      $redis.rpush(meme.slug, [new_price, 1].max)
      $redis.lpop(meme.slug) if $redis.llen(meme.slug) > 100
    end
  end
end
