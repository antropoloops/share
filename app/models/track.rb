# frozen_string_literal: true

class Track < ApplicationRecord

  include HasNameSlugged

  default_scope { order('position ASC, audioset_id ASC, created_at DESC') }

  belongs_to :audioset
  has_many :clips, dependent: :destroy

  validates :audioset, presence: true
  validates :name, presence: true, uniqueness: { scope: :audioset }
  validates :position, presence: true, uniqueness: { scope: :audioset }

end
