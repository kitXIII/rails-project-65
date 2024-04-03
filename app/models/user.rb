# frozen_string_literal: true

class User < ApplicationRecord
  has_many :bulletins, dependent: :destroy, inverse_of: 'author'

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP },
                    presence: true,
                    uniqueness: { case_sensitive: false }

  validates :name, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[name email admin]
  end

  def self.ransackable_associations(_auth_object = nil)
    []
  end

  def self.ransortable_attributes(_auth_object = nil)
    %w[name email]
  end
end
