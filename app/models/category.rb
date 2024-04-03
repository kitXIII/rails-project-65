# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :bulletins, dependent: :restrict_with_error

  def self.ransackable_attributes(_auth_object = nil)
    %w[id]
  end
end
