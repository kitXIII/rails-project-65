# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :bulletins, dependent: :restrict_with_error

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name]
  end

  def self.ransackable_associations(_auth_object = nil)
    []
  end

  def self.ransortable_attributes(_auth_object = nil)
    %w[name]
  end
end
