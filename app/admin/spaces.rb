# frozen_string_literal: true

ActiveAdmin.register Space do
  permit_params :name, :logo, :readme

  index do
    column :logo do |space|
      image_tag space.logo_url(:thumb) if space.logo
    end
    column :name
    column :description
    actions
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
