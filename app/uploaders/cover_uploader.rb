# frozen_string_literal: true

class CoverUploader < Shrine

  plugin :processing
  plugin :versions
  plugin :validation_helpers
  plugin :remote_url, max_size: 20 * 1024 * 1024

  # def generate_location(_io, context)
  #   clip = context[:record]
  #   version = context[:version]
  #   audioset = clip.audioset
  #   ext = File.extname(context[:metadata]['filename'])
  #   time = clip.updated_at.to_i

  #   "#{audioset.slug}/covers/#{clip.slug}-#{version}#{time}#{ext}"
  # end

  process(:store) do |io, _context|
    versions = { original: io }

    io.download do |original|
      pipeline = ImageProcessing::MiniMagick.source(original)
      versions[:thumb] = pipeline.resize_to_fill!(100, 100)
      versions[:small] = pipeline.resize_to_fill!(400, 400)
    end

    versions
  end

  Attacher.validate do
    validate_max_size 2.megabytes
    validate_extension_inclusion %w[jpg jpeg png gif]
  end

end
