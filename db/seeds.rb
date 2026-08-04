# Tạo tài khoản admin mặc định
User.create!(
  name: "User 1",
  email: "test1@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  admin: true,
  activated: true,
  activated_at: Time.zone.now
)

99.times do |n|
  name = Faker::Name.name
  email = "test#{n + 2}@gmail.com"
  password = "123456"

  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now
  )
end

puts "Created microposts"
users = User.order(:created_at).take(6)

30.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each {|user| user.microposts.create!(content: content)}
end

puts "Created relationships"
users = User.all.to_a
user = users.first
following = users[2..20]
followers = users[3..15]
following.each{|followed|user.follow(followed)}
followers.each{|follower|follower.follow(user)}
