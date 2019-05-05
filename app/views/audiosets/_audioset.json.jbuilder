# frozen_string_literal: true

json.id audioset.slug

json.meta do
  json.title audioset.name
  json.description audioset.description
  # FIXME: markdown
  json.readme audioset.readme
end

json.audio do
  json.bpm audioset.bpm
  json.defaults do
    json.loop true
  end
  json.signature [4, 4]
  json.trackMaxVoices 1
  json.quantize audioset.quantize
end

json.visuals do
  json.geoMapUrl audioset.geomap_url
  json.focus do
    json.lambda audioset.geomap_lambda
    json.verticalShift audioset.geomap_vshift
    json.scaleFactor audioset.geomap_scale
  end
end
