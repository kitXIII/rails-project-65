# frozen_string_literal: true

class ApplicationPolicy
  def initialize(user, record)
    @user = user
    @record = record
  end

  private

  attr_reader :user, :record
end
