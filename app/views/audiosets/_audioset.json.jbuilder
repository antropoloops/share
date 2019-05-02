# frozen_string_literal: true

json.id audioset.slug

json.meta do
  json.title audioset.name
  json.description audioset.description
  # FIXME: markdown
  json.readme audioset.readme
end

json.audio do
end

json.visuals do
end
