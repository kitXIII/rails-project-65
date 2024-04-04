# frozen_string_literal: true

namespace :supervisor do
  desc 'Creates user with admin role and email defined in SUPERADMIN_EMAIL env variable'
  task create: :environment do
    AdminHelper.create_supervisor
  end
end
