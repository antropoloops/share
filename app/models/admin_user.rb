# frozen_string_literal: true

class AdminUser < ApplicationRecord

  has_many :permissions
  has_many :audiosets, through: :permissions

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  def superadmin?
    role == ''
  end

  def has_audioset?(audioset)
    audiosets.where(id: audioset).exist?
  end

end
