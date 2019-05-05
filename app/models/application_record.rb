# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base

  self.abstract_class = true

  # Required because when using uuid the order doesn't correspond with the creation order
  default_scope { order(created_at: :desc) }

end
