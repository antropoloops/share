# frozen_string_literal: true

class AdminUserPolicy < ApplicationPolicy

  def index?
    user.superadmin?
  end

  def edit?
    user.superadmin?
  end

  def delete?
    user.superadmin?
  end

end
