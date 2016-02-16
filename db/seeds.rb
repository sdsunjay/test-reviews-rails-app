user1 = User.create :email => "user1@name.com", :password => "password"
user2 = User.create :email => "user2@name.com", :password => "password"
user3 = User.create :email => "user3@name.com", :password => "password"

posts = Post.create ([{user_id: 1, title: "test1"},{user_id: 2, title: "test2"},{user_id: 1, title: "test3"}])

