# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

3.times do |i|
    puts "creating user #{i+1}"
    user = User.create(
        name: "User #{i+1}",
        photo: "photo #{i+1}",
        bio: "bio #{i+1}",
        posts_counter: 0
    )
    3.times do |x|
        puts "creating post #{x+1} for user #{i+1}"
        post = Post.create(
            title: "title #{x+1}",
            text: "text #{x+1}",
            comments_counter: 0,
            likes_counter: 0,
            author: user
        )
        2.times do |z|
            puts "creating comment #{z+1} for post #{x+1}"
            Comment.create(
                text: "text #{z+1}",
                author: user,
                post: post
            )
        end
        2.times do |y|
            puts "creating like #{y+1} for post #{x+1}"
            Like.create(
                author: user,
                post: post
            )
        end
    end
end

