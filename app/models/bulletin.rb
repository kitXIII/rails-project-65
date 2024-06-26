# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM

  has_one_attached :image

  belongs_to :category
  belongs_to :user, inverse_of: 'bulletins'

  validates :image, attached: true,
                    content_type: %i[png jpg jpeg],
                    size: { less_than: 5.megabytes }

  validates :title, presence: true, length: { minimum: 2, maximum: 50 }
  validates :description, presence: true, length: { minimum: 2, maximum: 1000 }

  aasm column: :state, whiny_transitions: false do
    state :draft, initial: true
    state :archived, :published, :rejected, :under_moderation

    event :to_moderate do
      transitions from: :draft, to: :under_moderation
    end

    event :publish do
      transitions from: :under_moderation, to: :published
    end

    event :reject do
      transitions from: :under_moderation, to: :rejected
    end

    event :archive do
      transitions from: %i[draft published rejected under_moderation], to: :archived
    end
  end

  scope :published_or_created_by, ->(user) { published.or(Bulletin.where(user_id: user.id)) }

  def may_be_edited?
    draft? || under_moderation?
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[title description state]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[user category]
  end

  def self.ransortable_attributes(_auth_object = nil)
    %w[created_at updated_at title user category state]
  end
end
