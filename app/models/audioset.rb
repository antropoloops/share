# frozen_string_literal: true

##
# == SCHEMA==
# string "name", null: false
# string "slug", null: false
# string "description"
# string "readme"
# uuid "geomap_id"
# jsonb "logo_data"
# jsonb "background_data"
# string "display_mode"
# float "bpm"
# integer "quantize"
# string "play_mode"
# datetime "created_at", null: false
# datetime "updated_at", null: false
# string "geomap_url"
# float "geomap_lambda"
# float "geomap_vshift"
# float "geomap_hshift"
# float "geomap_scale"
class Audioset < ApplicationRecord

  extend FriendlyId
  friendly_id :name, use: %i(slugged finders)

  has_many :clips, dependent: :destroy
  has_many :tracks, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  include LogoUploader[:logo]
  include BackgroundUploader[:background]

  def public_logo_url(version)
    logo_url(version, public: true)
  end

end
