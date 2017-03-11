namespace :pricing do
  desc "Reset all meme prices"
  task reset: :environment do
    Meme.find_each do |meme|
      meme.update_columns(price: 1)
    end
  end

  desc "Update all meme prices"
  task update: :environment do
    Meme.find_each do |meme|
      meme.save
    end
  end

  desc "Generate fake meme prices"
  task fake: :environment do
    Meme.find_each do |meme|
      meme.update_columns(price: rand(10000))
    end
  end
end