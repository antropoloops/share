# frozen_string_literal: true

class Audioset < ApplicationRecord

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true, uniqueness: true
  include LogoUploader[:logo]

end
