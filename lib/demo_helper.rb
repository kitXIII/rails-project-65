# frozen_string_literal: true

class DemoHelper
  class << self
    def create_categories(number_of_categories = 1)
      number_of_categories.times do
        Category.find_or_create_by(
          name: Faker::Commerce.unique.department(max: 4)
        )
      end
    end

    def create_users(number_of_users = 1)
      number_of_users.times do
        User.create_with(
          name: Faker::FunnyName.name,
          admin: Faker::Boolean.boolean(true_ratio: 0.2)
        ).find_or_create_by(
          email: Faker::Internet.unique.email
        )
      end
    end

    def create_bulletins(number_of_bulletins = 1)
      number_of_bulletins.times do
        bulletin = Bulletin.new(
          title: Faker::Commerce.product_name,
          description: Faker::Books::Dune.quote,
          category: categories.sample,
          user: users.sample,
          state: states.sample
        )
        file_number = rand(10)
        bulletin.image.attach(io: File.open(Rails.root.join("lib/demo_files/#{file_number}.png").to_s),
                              filename: "#{file_number}.png",
                              content_type: 'image/png')
        bulletin.save
      end
    end

    def categories
      @categories ||= Category.all
      raise 'There is no any category. Create categories first.' if @categories.empty?

      @categories
    end

    def users
      @users ||= User.all
      raise 'There is no any user. Create users first.' if @users.empty?

      @users
    end

    def states
      %i[draft archived published rejected under_moderation]
    end
  end

  private_class_method :categories, :users, :states
end
