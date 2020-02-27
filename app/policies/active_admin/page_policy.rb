# frozen_string_literal: true

module ActiveAdmin
  class PagePolicy < ApplicationPolicy

    def show?
      puts "PAGE! #{record.name}"
      case record.name
      when 'Dashboard'
        true
      else
        false
      end
    end

  end
end
