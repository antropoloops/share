# frozen_string_literal: true

class AssetPolicy < ApplicationPolicy

  def index?
    user.superadmin?
  end

  def create?
    user.superadmin?
  end

  def update?
    user.superadmin?
  end

  def destroy?
    user.superadmin?
  end

end
