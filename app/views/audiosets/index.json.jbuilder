# frozen_string_literal: true

json.array! @audiosets do |audioset|
  json.id audioset.slug
  json.name audioset.name
  json.title audioset.name # Legacy
  json.description audioset.description
  json.url "#{url_for(audioset)}.json"
end
