# frozen_string_literal: true

class Clip < ApplicationRecord

  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :audioset

end
