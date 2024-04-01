# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where.not(id: AdminHelper.supervisor&.id)
    end
  end

  def edit?
    update?
  end

  def update?
    record.id != AdminHelper.supervisor&.id
  end
end
