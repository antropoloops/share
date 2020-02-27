# frozen_string_literal: true

class Permission < ApplicationRecord

  belongs_to :admin_user
  belongs_to :audioset

end
