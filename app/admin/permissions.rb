# frozen_string_literal: true

ActiveAdmin.register Permission do
  permit_params :audioset_id, :admin_user_id

  index do
    column :id
    column :admin_user
    column :audioset
    actions
  end

  form do |f|
    f.input :admin_user, member_label: 'email'
    f.input :audioset
    f.actions
  end
end
