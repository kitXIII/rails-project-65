# frozen_string_literal: true

class AdminHelper
  def self.supervisor
    @supervisor ||= User.find_by(email: ENV.fetch('SUPERADMIN_EMAIL'))
  end
end
