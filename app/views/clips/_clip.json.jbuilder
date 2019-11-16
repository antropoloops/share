# frozen_string_literal: true

json.id clip.slug
json.name clip.name
json.trackId clip.track.slug
json.trackNum clip.track.position
json.position [clip.xpos, clip.ypos]
json.extract! clip, :title, :album, :artist, :country, :place, :year
json.readme clip.readme
json.extract! clip, :key, :beats, :volume
json.keyMap clip.key
json.color clip.track.color

json.coverUrl clip.public_cover_url(:small)
json.audioUrl clip.audio_wav ? clip.public_audio_url(:wav) : clip.public_audio_url(:mp3)
json.resources do
  json.cover2 do
    json.small clip.public_cover2_url(:small)
    json.thumb clip.public_cover2_url(:thumb)
  end
  json.cover do
    json.small clip.public_cover_url(:small)
    json.thumb clip.public_cover_url(:thumb)
  end
  json.audio do
    json.mp3 clip.public_audio_url(:mp3)
    json.wav clip.public_audio_url(:wav)
    json.ogg clip.public_audio_url(:ogg)
  end
end

# compatibility legacy
json.keyboard clip.key
json.audio do
  json.extract! clip, :beats, :volume
end
