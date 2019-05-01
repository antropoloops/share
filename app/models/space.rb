# frozen_string_literal: true

class Space < ApplicationRecord

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  validates :name, presence: true, uniqueness: true
  include LogoUploader[:logo]

end
