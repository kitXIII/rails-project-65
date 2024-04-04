# frozen_string_literal: true

class AdminHelper
  def self.supervisor
    @supervisor ||= User.find_by(email: ENV.fetch('SUPERVISOR_EMAIL'))
  end

  def self.create_supervisor
    email = ENV.fetch('SUPERVISOR_EMAIL')
    return if email.blank?

    @supervisor = User.create_with(name: 'admin', admin: true).find_or_create_by(email:)
    @supervisor.update(admin: true) unless @supervisor.admin?
  end
end
