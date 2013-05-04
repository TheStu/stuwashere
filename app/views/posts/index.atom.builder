atom_feed do |feed|
  feed.title "Stu Was Here Posts"
  feed.updated Post.maximum('created_at')
  @posts.each do |post|
    feed.entry post do |entry|
      entry.title post.title
      entry.content post.content, type: 'html'
      entry.author do |author|
        author.name "Stuart Morris"
      end
    end
  end
end
