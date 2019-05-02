# frozen_string_literal: true

class Asset < ApplicationRecord

  include AssetUploader[:file]

end
