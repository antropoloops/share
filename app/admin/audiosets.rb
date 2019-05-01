# frozen_string_literal: true

ActiveAdmin.register Audioset do
  permit_params :name, :logo, :readme

  index do
    column :logo do |audioset|
      image_tag audioset.logo_url(:thumb) if audioset.logo
    end
    column :name
    column :description
    column :clips do |audioset|
      link_to audioset.clips.count, admin_space_assets_path(audioset)
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :readme
      f.input :logo, as: :file
    end
    f.actions
  end
end
