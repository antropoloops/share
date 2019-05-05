# frozen_string_literal: true

require 'kramdown'

ActiveAdmin.register Audioset do
  config.sort_order = 'created_at desc'
  permit_params :name, :audioset_id, :description,
                :readme, :logo, :background,
                :geomap_url, :geomap_lambda, :geomap_vshift, :geomap_scale,
                :display_mode, :bpm, :quantize, :play_mode
  config.batch_actions = true

  index do
    selectable_column
    column :logo do |audioset|
      image_tag audioset.logo_url(:thumb) if audioset.logo
    end
    column :name
    column :description
    column :clips do |audioset|
      link_to audioset.clips.count, admin_audioset_clips_path(audioset)
    end
    column :tracks do |audioset|
      link_to audioset.tracks.count, admin_audioset_tracks_path(audioset)
    end
    column :json do |audioset|
      link_to 'View', audioset_path(audioset, format: :json)
    end
    actions
  end

  show do
    div do
      div image_tag(audioset.public_logo_url(:small)) if audioset.logo
      h3 link_to('👉 Track list', admin_audioset_tracks_path(audioset.id))
      h3 link_to('👉 Clip list', admin_audioset_clips_path(audioset.id))
      h3 'Share urls'
      ul do
        li { link_to audioset_url(audioset, format: :json), audioset_path(audioset, format: :json) }
        li { link_to player_url(audioset), player_url(audioset) }
      end
    end
    attributes_table do
      row :id, &:slug
      row :name
      row :description
      row :json do |audioset|
        link_to audioset_url(audioset, format: :json), audioset_url(audioset, format: :json)
      end
      row :logo_data
      row :background_data
      row :display_mode
      row :geomap_url
      row :geomap_lambda
      row :geomap_vshift
      row :geomap_scale
      row :play_mode
      row :bpm
      row :quantize
      div do
        h3 'README'
        h2 audioset.name
        div do
          Kramdown::Document.new(audioset.readme).to_html.html_safe
        end
      end
    end
  end

  form do |f|
    f.inputs do
      f.inputs :name
      inputs 'Metadata' do
        f.input :description
        f.input :readme, as: :text
        f.input :logo, as: :file
      end
      inputs 'Visuals' do
        f.input :display_mode
        f.input :background, as: :file
        f.inputs :geomap_url, :geomap_lambda, :geomap_vshift, :geomap_scale
      end
      inputs 'Audio' do
        f.input :play_mode
        f.inputs :bpm, :quantize
      end
    end
    f.actions
  end
end
