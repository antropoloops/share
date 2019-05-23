# frozen_string_literal: true

class AssetUploader < Shrine

  plugin :determine_mime_type, analyzer: :marcel

  def generate_location(_io, context)
    asset = context[:record]
    # ext = File.extname(context[:metadata]['filename'])
    asset.name
  end

end
