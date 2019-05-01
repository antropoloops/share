# frozen_string_literal: true

class LogoUploader < Shrine

  plugin :processing
  plugin :versions
  plugin :validation_helpers

  process(:store) do |io, _context|
    versions = { original: io }

    io.download do |original|
      pipeline = ImageProcessing::MiniMagick.source(original)
      versions[:thumb] = pipeline.resize_to_fill!(100, 100)
      versions[:small] = pipeline.resize_to_limit!(400, 400)
    end

    versions
  end

  Attacher.validate do
    validate_max_size 2.megabytes
    validate_extension_inclusion %w[jpg jpeg png gif]
  end

end
