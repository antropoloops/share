# frozen_string_literal: true

class Asset < ApplicationRecord

  extend FriendlyId
  friendly_id :name, use: :slugged

  include AssetUploader[:file]

  validates :name, presence: true, uniqueness: true
  validates :file, presence: true

end
