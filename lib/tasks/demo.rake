# frozen_string_literal: true

DEFAULT_NUMBER_OF_CATEGORIES = 5
DEFAULT_NUMBER_OF_USERS = 10
DEFAULT_NUMBER_OF_BULLETINS = 10

namespace :demo do
  desc 'Fills app with demo data: categories, users and bulletins'
  task :create, %i[users categories bulletins] => :environment do
    users = ENV.fetch('users', nil)
    categories = ENV.fetch('categories', nil)
    bulletins = ENV.fetch('bulletins', nil)

    Rake::Task['demo:categories:create'].invoke(categories) if categories
    Rake::Task['demo:users:create'].invoke(users) if users
    Rake::Task['demo:bulletins:create'].invoke(bulletins) if bulletins
  end

  namespace :categories do
    desc "Creates number of categories, default: #{DEFAULT_NUMBER_OF_CATEGORIES}"
    task :create, [:number] => :environment do |_, args|
      number = (args[:number] || ENV.fetch('number', nil) || DEFAULT_NUMBER_OF_CATEGORIES).to_i

      puts 'Task started...'
      DemoHelper.create_categories(number)
      puts "#{number} categories was creted"
    end
  end

  namespace :users do
    desc "Creates number of users, default: #{DEFAULT_NUMBER_OF_USERS}"
    task :create, [:number] => :environment do |_, args|
      number = (args[:number] || ENV.fetch('number', nil) || DEFAULT_NUMBER_OF_USERS).to_i

      puts 'Task started...'
      DemoHelper.create_users(number)
      puts "#{number} users was creted"
    end
  end

  namespace :bulletins do
    desc "Creates number of bulletins, default: #{DEFAULT_NUMBER_OF_BULLETINS}"
    task :create, [:number] => :environment do |_, args|
      number = (args[:number] || ENV.fetch('number', nil) || DEFAULT_NUMBER_OF_BULLETINS).to_i

      puts 'Task started...'
      DemoHelper.create_bulletins(number)
      puts "#{number} bulletins was creted"
    end
  end
end
