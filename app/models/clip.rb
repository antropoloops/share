# frozen_string_literal: true

class Clip < ApplicationRecord

  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :audioset
  belongs_to :track

  validates :audioset, presence: true
  validates :track, presence: true
  validates :name, presence: true, uniqueness: { scope: :audioset }

  include CoverUploader[:cover]
  include AudioUploader[:audio_mp3]
  include AudioUploader[:audio_wav]

  def public_cover_url(version)
    cover_url(version, public: true)
  end

  def public_audio_url(version)
    public_send("audio_#{version}_url", public: true)
  end

end
