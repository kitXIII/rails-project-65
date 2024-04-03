# frozen_string_literal: true

MIN_USERS_COUNT = 20
MIN_CATEGORIES_COUNT = 5
MIN_BULLETINS_COUNT = 50

if User.count < MIN_USERS_COUNT
  (MIN_USERS_COUNT - User.count).times do
    User.create(
      name: Faker::FunnyName.name,
      email: Faker::Internet.unique.email,
      admin: Faker::Boolean.boolean(true_ratio: 0.2)
    )
  end
end

if Category.count < MIN_CATEGORIES_COUNT
  (MIN_CATEGORIES_COUNT - Category.count).times do
    Category.create(
      name: Faker::Commerce.unique.department(max: 3)
    )
  end
end

if Bulletin.count < MIN_BULLETINS_COUNT
  categories = Category.all
  users = User.all
  states = %i[draft archived published rejected under_moderation]
  (MIN_BULLETINS_COUNT - Bulletin.count).times do |i|
    bulletin = Bulletin.new(
      title: Faker::Commerce.product_name,
      description: Faker::Books::Dune.quote,
      category: categories.sample,
      author: users.sample,
      state: states.sample
    )
    bulletin.image.attach(io: File.open(Rails.root.join("db/files/#{i % 10}.png").to_s),
                          filename: "#{i}.png",
                          content_type: 'image/png')
    bulletin.save
  end
end
