# frozen_string_literal: true

class Track < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  default_scope { order('position ASC, audioset_id ASC, created_at DESC') }

  belongs_to :audioset
  has_many :clips, dependent: :destroy

  validates :audioset, presence: true
  validates :position, presence: true, uniqueness: { scope: :audioset_id }

end
