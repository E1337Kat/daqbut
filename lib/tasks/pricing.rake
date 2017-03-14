namespace :pricing do
  desc "Reset all meme prices"
  task reset: :environment do
    Meme.find_each do |meme|
      $redis.del(meme.slug)
      meme.update_columns(price: 1)
    end
    $redis.del('DAQBUT')
  end

  desc "Update all meme prices"
  task update: :environment do
    Meme.find_each do |meme|
      meme.save
    end
    $redis.lpush(meme.slug, Meme.visible.average(:price))
  end

  desc "Generate fake meme prices"
  task fake: :environment do
    Meme.find_each do |meme|
      100.times{ $redis.lpush(meme.slug, rand(10000)) }
      meme.update_columns(price: rand(10000))
    end
    $redis.lpush(meme.slug, Meme.visible.average(:price))
  end
end
