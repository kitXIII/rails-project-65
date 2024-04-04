# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      if !user
        scope.published
      elsif user.admin?
        scope.all
      else
        scope.published_or_created_by(user)
      end
    end
  end

  def new?
    create?
  end

  def create?
    user
  end

  def edit?
    update?
  end

  def update?
    author? && (record.draft? || record.under_moderation?)
  end

  private

  def author?
    user && record.user == user
  end
end
