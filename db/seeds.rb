User.create!(name:  "Rodrigo",
             email: "rgloop@gmail.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

20.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
              email: email,
              password:              password,
              password_confirmation: password,
              activated: true,
              activated_at: Time.zone.now)
end

Category.create!(name:"Protein Products",    desc: "Ideal for those sportsman trying to reach the next level")
Category.create!(name:"Strength & Recovery", desc: "Not enough power to fullfill your desires?")
Category.create!(name:"Health & Wellness",   desc: "Live a healthy life")

60.times do |n|
  name = "product-#{n+1}"
  units = rand(25..99)
  fraction = [0,50,99].sample
  price = "#{units}.#{fraction}"
  cat_num = (n % 3) + 1
  featured = n % 5 == 0 ? true : false
  random_num = rand(1..8)
  img = File.open(File.join(Rails.root, "app/assets/images/product_#{random_num}.jpg"))
  Product.create!(name:  name, price: price, category_id: cat_num.to_s, featured:featured, picture: img )
end


OrderStatus.create! id: 1, name: "In Progress"
OrderStatus.create! id: 2, name: "Placed"
OrderStatus.create! id: 3, name: "Sent"