namespace :pricing do
  desc "Update all meme prices"
  task update: :environment do
    Meme.find_each do |meme|
      $redis.rpush(meme.slug, rand(10000))
    end
  end
end
