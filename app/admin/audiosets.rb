# frozen_string_literal: true

ActiveAdmin.register Audioset do
  permit_params :name, :logo, :readme
  config.batch_actions = true

  index do
    selectable_column
    column :logo do |audioset|
      image_tag audioset.logo_url(:thumb) if audioset.logo
    end
    column :name
    column :description
    column :clips do |audioset|
      link_to audioset.clips.count, '#'
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :json do |audioset|
        link_to audioset_url(audioset, format: :json), audioset_url(audioset, format: :json)
      end
      row :description
      row :display_mode
      row :geomap
      row :bpm
      row :quantize
      row :play_mode
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :readme
      f.input :logo, as: :file
      inputs 'Visuals' do
        f.input :geomap
      end
      inputs 'Audio' do
        f.inputs :bpm, :quantize
      end
    end
    f.actions
  end
end
