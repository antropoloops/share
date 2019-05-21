# frozen_string_literal: true

class BackgroundUploader < Shrine

  plugin :validation_helpers

  Attacher.validate do
    validate_max_size 1.megabytes
    validate_extension_inclusion %w[jpg jpeg png gif]
  end

end
