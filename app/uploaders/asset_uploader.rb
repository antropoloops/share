# frozen_string_literal: true

class AssetUploader < Shrine

  plugin :determine_mime_type, analyzer: :marcel

end
