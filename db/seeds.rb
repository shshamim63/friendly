# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(
  first_name: 'Homero',
  last_name: 'Simpson',
  username: 'Homero',
  email: 'homero@simpson.com',
  password: '123456',
  gender: 'male',
  birthday: '04-05-1982'
)
User.create(
  first_name: 'Gerald',
  last_name: 'De Rivia',
  username: 'Gerald',
  email: 'gerald@derivia.com',
  password: '123456',
  gender: 'male',
  birthday: '06-10-1942'
)
User.create(
  first_name: 'John',
  last_name: 'Wick',
  username: 'John',
  email: 'john@wick.com',
  password: '123456',
  gender: 'male',
  birthday: '06-11-1990'
)
User.create(
  first_name: 'Tony',
  last_name: 'Versetti',
  username: 'Tony',
  email: 'tony@versetti.com',
  password: '123456',
  gender: 'male',
  birthday: '05-07-1950'
)
User.create(
  first_name: 'Diana',
  last_name: 'Prince',
  username: 'WonderWoman',
  email: 'diana@prince.com',
  password: '123456',
  gender: 'female',
  birthday: '05-07-1995'
)

Post.create(
  content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
  user: User.first
)
Post.create(
  content: 'Orci varius natoque et magnis dis parturient montes.',
  user: User.second
)

Comment.create(
  content: 'Buen Post',
  post: Post.first,
  user: User.third
)
Comment.create(
  content: 'Gracias!',
  post: Post.first,
  user: User.first
)

Like.create(
  object: Post.first,
  object_type: 'Post',
  user: User.third,
  reaction_type: 'like'
)
Like.create(
  object: Comment.first,
  object_type: 'Comment',
  user: User.first,
  reaction_type: 'laugh'
)
Like.create(
  object: Comment.first,
  object_type: 'Comment',
  user: User.fourth,
  reaction_type: 'dislike'
)

Friendship.create(
  user: User.first,
  friend: User.second,
  status: 'accepted'
)
Friendship.create(
  user: User.first,
  friend: User.third,
  status: 'accepted'
)
Friendship.create(
  user: User.fourth,
  friend: User.first,
  status: 'accepted'
)
Friendship.create(
  user: User.second,
  friend: User.third,
  status: 'accepted'
)
Friendship.create(
  user: User.second,
  friend: User.fourth,
  status: 'rejected'
)
Friendship.create(
  user: User.third,
  friend: User.fourth,
  status: 'rejected'
)
Friendship.create(
  user: User.second,
  friend: User.fourth,
  status: 'accepted'
)
Friendship.create(
  user: User.second,
  friend: User.fourth,
  status: 'unfriended'
)
