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

  TYPES = %w[audioset project page].freeze

  extend FriendlyId
  friendly_id :name, use: %i(slugged finders)

  has_many :clips, dependent: :destroy
  has_many :tracks, dependent: :destroy
  belongs_to :parent, class_name: 'Audioset', optional: true

  validates :name, presence: true, uniqueness: true
  validates :publish_path, uniqueness: { allow_blank: true },
                           format: { with: %r{\A[-a-z0-9./]*\z}, message: 'Solo letras puntos y /' }
  validates :audioset_type, presence: true
  include LogoUploader[:logo]
  include BackgroundUploader[:background]

  def public_logo_url(version)
    logo_url(version, public: true)
  end

  def project?
    audioset_type == 'project'
  end

  def project_children
    return [] if children.blank?

    children.split("\n").map do |path|
      Audioset.find_by(publish_path: path.strip)
    end.compact
  end

  def publish
    return unless publish_path

    view_context_path = Rails.root.join('app', 'views')
    view = ApplicationController.view_context_class.new(view_context_path)
    content = JbuilderTemplate.new(view).encode do |json|
      json.partial! 'audiosets/audioset', audioset: self
    end
    filename = "#{publish_path}.audioset.json"
    share = Share.create(name: filename, content: content.to_json.to_s, content_type: 'application/json')
    share&.publish
  end

end
