# frozen_string_literal: true

categories = ['Для дома', 'Транспорт', 'Недвижимость', 'Хобби и отдых', 'Работа', 'Электроника', 'Животные']

categories.each do |name|
  Category.find_or_create_by!(name:)
end
