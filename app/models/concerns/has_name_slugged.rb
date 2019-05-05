# frozen_string_literal: true

module HasNameSlugged
  extend ActiveSupport::Concern

  included do
    extend FriendlyId
    friendly_id :name, use: %i(slugged finders)
  end

  def should_generate_new_friendly_id?
    persisted? && name_changed?
  end
end
