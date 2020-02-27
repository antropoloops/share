# frozen_string_literal: true

##
# ==SCHEMA==
# uuid "audioset_id"
# uuid "track_id"
# string "name", null: false
# string "slug", null: false
# jsonb "cover_data"
# jsonb "cover2_data"
# jsonb "audio_mp3_data"
# jsonb "audio_wav_data"
# jsonb "audio_ogg_data"
# string "description"
# string "title"
# string "album"
# string "artist"
# string "year"
# string "country"
# string "place"
# string "readme"
# float "xpos"
# float "ypos"
# string "color"
# string "key"
# float "beats"
# float "volume"
class Clip < ApplicationRecord

  include HasNameSlugged

  belongs_to :audioset
  belongs_to :track

  validates :name, presence: true, uniqueness: { scope: :audioset }
  validates :key, length: { maximum: 1 }
  validates :key, uniqueness: { scope: :audioset }, if: -> { key.present? }

  include CoverUploader[:cover]
  include CoverUploader[:cover2]
  include AudioUploader[:audio_mp3]
  include AudioUploader[:audio_wav]
  include AudioUploader[:audio_ogg]

  def public_cover_url(version)
    cover_url(version, public: true)
  end

  def public_cover2_url(version)
    cover2_url(version, public: true)
  end

  def public_audio_url(version)
    public_send("audio_#{version}_url", public: true)
  end

end
