# frozen_string_literal: true

module BulletinHelper
  STATE_BADGE_COLORS = {
    draft: :primary,
    under_moderation: :danger,
    published: :success,
    rejected: :warning,
    archived: :secondary
  }.freeze

  def state_badge_classes(state)
    "badge text-bg-#{STATE_BADGE_COLORS[state.to_sym] || :dark}"
  end
end
