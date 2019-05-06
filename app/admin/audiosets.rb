# frozen_string_literal: true

require 'kramdown'

ActiveAdmin.register Audioset do
  config.sort_order = 'created_at desc'
  config.batch_actions = false
  permit_params :name, :audioset_id, :description,
                :readme, :logo, :background,
                :geomap_url, :geomap_lambda, :geomap_vshift, :geomap_scale,
                :display_mode, :bpm, :quantize, :play_mode

  index as: :grid, columns: 2 do |audioset|
    render partial: 'audioset', locals: { audioset: audioset }
  end

  # index do
  #   selectable_column
  #   column :logo do |audioset|
  #     image_tag audioset.logo_url(:thumb) if audioset.logo
  #   end
  #   column :name
  #   column :description
  #   column :clips do |audioset|
  #     link_to audioset.clips.count, admin_audioset_clips_path(audioset)
  #   end
  #   column :tracks do |audioset|
  #     link_to audioset.tracks.count, admin_audioset_tracks_path(audioset)
  #   end
  #   column :json do |audioset|
  #     link_to 'View', audioset_path(audioset, format: :json)
  #   end
  #   actions
  # end

  show do
    div do
      Kramdown::Document.new(audioset.readme).to_html.html_safe
    end
    div do
      h3 link_to("Tracks: #{audioset.tracks.count}", admin_audioset_tracks_path(audioset.id))
      h3 link_to("Clips: #{audioset.clips.count}", admin_audioset_clips_path(audioset.id))
      h5 link_to player_url(audioset), player_url(audioset)
      h5 link_to audioset_url(audioset, format: :json), audioset_url(audioset, format: :json)
    end
    attributes_table do
      row :id, &:slug
      row :name
      row :description
      row :logo do |audioset|
        if audioset.logo
          ul do
            li image_tag(audioset.public_logo_url(:thumb))
            li link_to "100x100: #{audioset.public_logo_url(:thumb)}", audioset.public_logo_url(:thumb)
            li link_to "400x400: #{audioset.public_logo_url(:small)}", audioset.public_logo_url(:small)
          end
        end
      end
      row :display_mode
      row :geomap_url
      row :geomap_lambda
      row :geomap_vshift
      row :geomap_scale
      row :play_mode
      row :bpm
      row :quantize
      row :logo_data
      row :background_data
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
