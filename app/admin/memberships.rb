# frozen_string_literal: true

ActiveAdmin.register Membership do
  permit_params :user_id, :space_id, :level

  form do |f|
    f.inputs do
      f.input :user
      f.input :space
      f.input :level
    end
    f.actions
  end
end
