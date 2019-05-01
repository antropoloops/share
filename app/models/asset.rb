# frozen_string_literal: true

class Asset < ApplicationRecord

  belongs_to :space
  belongs_to :user

  include AssetUploader[:file]

end
