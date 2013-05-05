task :reset_impression_count => :environment do
  if Time.now.day == 1
    Post.find_each do |post|
      post.update_attributes(impression_count: 0)
    end
  end
end
