# frozen_string_literal: true

json.id clip.slug
json.track clip.track.slug
json.trackNum clip.track.position
json.extract! clip, :title, :album, :artist, :country, :place, :year, :xpos, :ypos
json.extract! clip, :key, :color, :beats, :volume

# compatibility legacy
json.lnglat [clip.xpos, clip.ypos]
json.keyboard clip.key
json.display do
  json.color clip.color
end
json.audio do
  json.extract! clip, :beats, :volume
end
