# frozen_string_literal: true

class AudiosetPolicy < ApplicationPolicy

  class Scope

    attr_reader :user, :scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.superadmin?
        scope.all
      else
        ids = user.permissions.pluck(:audioset_id)
        scope.where(id: ids)
      end
    end

  end

  def create?
    user.superadmin?
  end

  def destroy?
    user.superadmin?
  end

end
