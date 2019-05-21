# frozen_string_literal: true

class AudioUploader < Shrine

  plugin :validation_helpers
  plugin :remote_url, max_size: 20 * 1024 * 1024

  Attacher.validate do
    validate_extension_inclusion %w[wav mp3 ogg]
  end

end
