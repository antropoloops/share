# frozen_string_literal: true

ActiveAdmin.register Asset do
  permit_params :name, :file, :description

  index do
    column :name
    column :file do |asset|
      asset.file_url(public: true)
    end
    column :mime_type do |asset|
      asset.file_data['metadata']['mime_type']
    end
    column :description
    actions
  end

  show do
    attributes_table do
      row :name
      row :file do |asset|
        link_to asset.file_url(public: true), asset.file_url(public: true)
      end
      row :file_data
      row :description
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :file, as: :file
      f.input :description
    end
    f.actions
  end
end
