# frozen_string_literal: true

json.id clip.slug
json.trackId clip.track.slug
json.trackNum clip.track.position
json.position do
  json.x clip.xpos
  json.y clip.ypos
end
json.extract! clip, :title, :album, :artist, :country, :place, :year
json.extract! clip, :key, :beats, :volume
json.keyMap clip.key
json.color clip.track.color

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
    json.ogg clip.public_audio_url(:ogg)
  end
end

# compatibility legacy
json.extract! clip, :xpos, :ypos
json.lnglat [clip.xpos, clip.ypos]
json.keyboard clip.key
json.display do
  json.color clip.track.color
end
json.audio do
  json.extract! clip, :beats, :volume
end
