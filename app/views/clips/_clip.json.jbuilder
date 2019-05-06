# frozen_string_literal: true

json.id clip.slug
json.trackId clip.track.slug
json.trackNum clip.track.position
json.extract! clip, :title, :album, :artist, :country, :place, :year, :xpos, :ypos
json.extract! clip, :key, :color, :beats, :volume

json.coverUrl clip.public_cover_url(:small)
json.audioUrl clip.audio_wav ? clip.public_audio_url(:wav) : clip.public_audio_url(:mp3)
json.resources do
  json.cover do
    json.small clip.public_cover_url(:small)
    json.thumb clip.public_cover_url(:thumb)
  end
  json.audio do
    json.mp3 clip.public_audio_url(:mp3)
    json.wav clip.public_audio_url(:wav)
  end
end

# compatibility legacy
json.lnglat [clip.xpos, clip.ypos]
json.keyboard clip.key
json.display do
  json.color clip.color
end
json.audio do
  json.extract! clip, :beats, :volume
end
