# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
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
    record.author == user
  end
end
