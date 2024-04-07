# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def edit?
    update?
  end

  def update?
    record.id != AdminHelper.supervisor&.id
  end
end
