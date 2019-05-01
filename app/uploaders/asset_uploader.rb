# frozen_string_literal: true

class AssetUploader < Shrine

  plugin :processing
  plugin :versions

  process(:store) do |io, _context|
    versions = { original: io }

    io.download do |original|
      pipeline = ImageProcessing::MiniMagick.source(original)
      versions[:thumb] = pipeline.resize_to_fill!(100, 100)
      versions[:small] = pipeline.resize_to_limit!(400, 400)
    end

    versions
  end

end
