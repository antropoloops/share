# frozen_string_literal: true

ActiveAdmin.register Share do
  permit_params :name, :content_type, :content
  config.sort_order = 'published created_at desc'

  controller do
    actions :all, except: %i(edit destroy)
  end

  includes :previous

  index do
    column :name
    column :content_type
    column :published
    column :created_at
    column :previous
    actions
  end

  show do
    attributes_table do
      row :published
      row :name
      row :content_type
      row :created_at
      row :previous
      row :content
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :content_type, collection: Share::CONTENT_TYPES, include_blank: false
      f.input :content
    end
    f.actions
  end
end
