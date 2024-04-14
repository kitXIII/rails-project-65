# frozen_string_literal: true

if Rails.env.development?
  DemoHelper.create_categories(5)
  DemoHelper.create_users(5)

  AdminHelper.try_create_supervisor

  DemoHelper.create_bulletins(30)
end
