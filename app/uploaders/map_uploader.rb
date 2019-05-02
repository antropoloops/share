# frozen_string_literal: true

class MapUploader < Shrine

  plugin :determine_mime_type, analyzer: :marcel
  plugin :validation_helpers

  def generate_location(_io, context)
    "geomaps/#{context[:record].name}.json"
  end

  Attacher.validate do
    validate_extension_inclusion %w[json]
  end

end
