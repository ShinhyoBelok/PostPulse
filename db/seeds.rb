# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# 3.times do |i|
#     puts "creating user #{i+1}"
#     user = User.create(
#         name: "User #{i+1}",
#         photo: "https://cdn3.iconfinder.com/data/icons/avatars-flat/33/man_5-512.png",
#         bio: "bio #{i+1}",
#         posts_counter: 0
#     )
#     3.times do |x|
#         puts "creating post #{x+1} for user #{i+1}"
#         post = Post.create(
#             title: "title #{x+1}",
#             text: "text #{x+1}",
#             comments_counter: 0,
#             likes_counter: 0,
#             author: user
#         )
#         2.times do |z|
#             puts "creating comment #{z+1} for post #{x+1}"
#             Comment.create(
#                 text: "text #{z+1}",
#                 author: user,
#                 post: post
#             )
#         end
#         2.times do |y|
#             puts "creating like #{y+1} for post #{x+1}"
#             Like.create(
#                 author: user,
#                 post: post
#             )
#         end
#     end
# end

# first_user = User.create(name: 'Tom', photo: 'https://cdn3.iconfinder.com/data/icons/avatars-flat/33/man_5-512.png', bio: 'Teacher from Mexico.', posts_counter: 0)
# second_user = User.create(name: 'Lilly', photo: 'https://cdn3.iconfinder.com/data/icons/avatars-flat/33/man_5-512.png', bio: 'Teacher from Poland.', posts_counter: 0)

# first_post = Post.create(author: first_user, title: 'Hello1', text: 'This is my 1 post', comments_counter: 0, likes_counter: 0)
# Post.create(author: first_user, title: 'Hello2', text: 'This is my 2 post', comments_counter: 0, likes_counter: 0)
# Post.create(author: first_user, title: 'Hello3', text: 'This is my 3 post', comments_counter: 0, likes_counter: 0)
# Post.create(author: first_user, title: 'Hello4', text: 'This is my 4 post', comments_counter: 0, likes_counter: 0)
# Post.create(author: second_user, title: 'Hello5', text: 'This is my 5 post', comments_counter: 0, likes_counter: 0)
# Post.create(author: second_user, title: 'Hello6', text: 'This is my 6 post', comments_counter: 0, likes_counter: 0)

# Comment.create(post: first_post, author: second_user, text: 'Hi Tom!1' )
# Comment.create(post: first_post, author: second_user, text: 'Hi Tom!2' )
# Comment.create(post: first_post, author: second_user, text: 'Hi Tom!3' )
# Comment.create(post: first_post, author: second_user, text: 'Hi Tom!4' )
# Comment.create(post: first_post, author: second_user, text: 'Hi Tom!5' )
# Comment.create(post: first_post, author: second_user, text: 'Hi Tom!6' )