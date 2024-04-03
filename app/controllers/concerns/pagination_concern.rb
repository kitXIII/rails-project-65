# frozen_string_literal: true

module PaginationConcern
  def page
    params.fetch(:page, 1)
  end
end
