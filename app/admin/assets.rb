# frozen_string_literal: true

ActiveAdmin.register Asset do
  permit_params :name, :file, :description

  index do
    column :name
    column :file_data
    column :description
    actions
  end

  show do
    attributes_table do
      row :name
      row :map do |asset|
        link_to asset.file_url(public: true), asset.file_url(public: true)
      end
      row :description
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :logo, as: :file
    end
    f.actions
  end
end
