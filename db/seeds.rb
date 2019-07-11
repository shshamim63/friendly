# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(first_name: 'Homero', last_name: 'Simpson', email: 'homero@simpson.com', password: '123456')
User.create(first_name: 'Gerald', last_name: 'De Rivia', email: 'gerald@derivia.com', password: '123456')
User.create(first_name: 'Jhon', last_name: 'Wick', email: 'jhon@wick.com', password: '123456')
User.create(first_name: 'Tony', last_name: 'Versetti', email: 'tony@versetti.com', password: '123456')

Post.create(content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', user: User.first)
Post.create(content: 'Orci varius natoque penatibus et magnis dis parturient montes.', user: User.second)

Comment.create(content: 'Buen Post', post: Post.first, user: User.third)
Comment.create(content: 'Gracias!', post: Post.first, user: User.first, reply_from: Comment.first)

Like.create(post: Post.first, object_class: 'Post', user: User.third, reaction_type: 'like')
Like.create(comment: Comment.first, object_class: 'Comment', user: User.first, reaction_type: 'laugh')
Like.create(comment: Comment.first, object_class: 'Comment', user: User.fourth, reaction_type: 'dislike')

Friendship.create(user: User.first, friend: User.second, status: 'accepted')
Friendship.create(user: User.first, friend: User.third, status: 'accepted')
Friendship.create(user: User.fourth, friend: User.first, status: 'accepted')
Friendship.create(user: User.second, friend: User.third, status: 'accepted')
