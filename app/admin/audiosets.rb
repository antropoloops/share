# frozen_string_literal: true

require 'kramdown'

ActiveAdmin.register Audioset do
  config.sort_order = 'created_at desc'
  config.batch_actions = false
  permit_params :name, :audioset_id, :description,
                :readme, :logo, :background,
                :geomap_url, :geomap_lambda, :geomap_vshift, :geomap_scale,
                :display_mode, :bpm, :quantize, :play_mode

  action_item :tracks, only: :show do
    link_to "Tracks: #{audioset.tracks.count}", admin_audioset_tracks_path(resource)
  end

  action_item :new_clip, only: :show do
    link_to "Clips: #{audioset.clips.count}", admin_audioset_clips_path(resource)
  end

  index as: :grid, columns: 3 do |audioset|
    render partial: 'audioset', locals: { audioset: audioset }
  end

  show do
    div do
      Kramdown::Document.new(audioset.readme).to_html.html_safe
    end
    div do
      h1 "Audioset: #{audioset.slug}"
      h3 link_to("Tracks: #{audioset.tracks.count}", admin_audioset_tracks_path(audioset.id))
      h3 link_to("Clips: #{audioset.clips.count}", admin_audioset_clips_path(audioset.id))
      h5 link_to player_url(audioset), player_url(audioset)
      h5 link_to audioset_url(audioset, format: :json), audioset_url(audioset, format: :json)
    end
    attributes_table(title: 'Meta') do
      row :id, &:slug
      row :name
      row :description
      row :readme, as: :text
      row :logo do |audioset|
        if audioset.logo
          ul do
            li image_tag(audioset.public_logo_url(:thumb))
            li link_to "100x100: #{audioset.public_logo_url(:thumb)}", audioset.public_logo_url(:thumb)
            li link_to "400x400: #{audioset.public_logo_url(:small)}", audioset.public_logo_url(:small)
            li link_to "Original: #{audioset.public_logo_url(:original)}", audioset.public_logo_url(:original)
          end
        end
      end
    end
    attributes_table(title: 'Visuals') do
      row :background do |audioset|
        if audioset.background
          ul do
            li link_to("Image: #{audioset.background_url(public: true)}",
                       audioset.background_url(public: true))
            li "Dimensions: #{audioset.background_data['metadata']['width']}x" \
               "#{audioset.background_data['metadata']['height']}px"
          end
        end
      end
      row :display_mode
      row :geomap_url
      row :geomap_lambda
      row :geomap_vshift
      row :geomap_scale
    end
    attributes_table(title: 'Audio') do
      rows :play_mode, :bpm, :quantize
    end
    attributes_table(title: 'Files') do
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
        f.input :background, as: :file
        f.input :display_mode
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
