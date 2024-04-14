# frozen_string_literal: true

class AdminHelper
  DEFAULT_ADMIN_NAME = 'admin'

  def self.supervisor
    @supervisor ||= supervisor_email? ? User.find_by(email: supervisor_email) : nil
  end

  def self.try_register_or_create_supervisor
    if supervisor.present?
      supervisor.update(admin: true) unless supervisor.admin?
    else
      try_create_supervisor
    end
  end

  def self.try_create_supervisor
    return unless supervisor_email?

    User.create(name: DEFAULT_ADMIN_NAME, email: supervisor_email, admin: true)
  end

  def self.supervisor_email
    @supervisor_email ||= ENV.fetch('SUPERVISOR_EMAIL', nil)
  end

  def self.supervisor_email?
    supervisor_email.present?
  end

  private_class_method :supervisor_email?, :supervisor_email
end
