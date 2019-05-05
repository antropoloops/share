# frozen_string_literal: true

class Audioset < ApplicationRecord

  extend FriendlyId
  friendly_id :name, use: %i(slugged finders)

  has_many :clips, dependent: :destroy
  has_many :tracks, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  include LogoUploader[:logo]

  def public_logo_url(version)
    logo_url(version, public: true)
  end

end
