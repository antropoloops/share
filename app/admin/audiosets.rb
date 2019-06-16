# frozen_string_literal: true

require 'kramdown'

ActiveAdmin.register Audioset do
  # ==INDEX==
  config.sort_order = 'created_at desc'
  config.batch_actions = false
  index as: :grid, columns: 6 do |audioset|
    render partial: 'audioset', locals: { audioset: audioset }
  end

  # ==SHOW==
  action_item :tracks, only: :show do
    link_to "Tracks: #{audioset.tracks.count}", admin_audioset_tracks_path(resource)
  end

  action_item :new_clip, only: :show do
    link_to "Clips: #{audioset.clips.count}", admin_audioset_clips_path(resource)
  end

  action_item :publish, only: :show do
    link_to 'Publish!', publish_admin_audioset_path(audioset), method: :post
  end

  member_action :publish, method: :post do
    audioset = resource
    if audioset.publish_path.present?
      audioset.publish
      notice = "Audioset published! #{audioset.publish_path}"
    else
      notice = "Can't publish an audioset without publish path"
    end

    redirect_to admin_audioset_path(audioset), notice: notice
  end

  show do
    div do
      Kramdown::Document.new(audioset.readme).to_html.html_safe
    end
    div do
      h1 "Audioset: #{audioset.slug}"
      if audioset.audioset_type == 'project'
        h3 'This audioset is a project! No tracks and no clips. Use children'
      elsif audioset.audioset_type == 'page'
        h3 'This audioset is a page! No tracks and no clips. Use readme'
      else
        h3 link_to("Tracks: #{audioset.tracks.count}", admin_audioset_tracks_path(audioset.id))
        h3 link_to("Clips: #{audioset.clips.count}", admin_audioset_clips_path(audioset.id))
      end
      h5 link_to "Test player: #{player_url(audioset)}", player_url(audioset)
      if audioset.publish_path.present?
        h5 link_to "Published at: #{player_path(audioset)}", player_path(audioset)
      end
      h5 link_to "View data: #{audioset_url(audioset, format: :json)}",
                 audioset_url(audioset, format: :json)
    end
    attributes_table(title: 'Audioset') do
      row :id, &:slug
      row :audioset_type
      row :parent
    end
    attributes_table(title: 'Meta') do
      row :publish_path
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
    if audioset.project?
      attributes_table(title: 'Project') do
        row :children do |audioset|
          ul do
            audioset.project_children.map do |children|
              li link_to(children.name, admin_audioset_path(children))
            end.join(' ')
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
      row :geomap_center_x
      row :geomap_center_y
    end
    attributes_table(title: 'Audio') do
      rows :play_mode, :bpm, :quantize
    end
    attributes_table(title: 'Files') do
      row :logo_data
      row :background_data
    end
  end

  # == FORM ==
  permit_params :name, :audioset_id, :description,
                :publish_path, :parent_id, :audioset_type, :children,
                :readme, :logo, :background,
                :geomap_url, :geomap_lambda, :geomap_vshift, :geomap_scale,
                :geomap_center_x, :geomap_center_y,
                :display_mode, :bpm, :quantize, :play_mode
  form do |f|
    f.inputs do
      f.input :name
      f.input :audioset_type, collection: Audioset::TYPES, include_blank: false
      f.input :parent_id, as: :select, collection: Audioset.where.not(id: audioset.id)
      f.input :publish_path
      inputs 'Metadata' do
        f.input :description
        f.input :readme, as: :text
        f.input :logo, as: :file
      end
      inputs 'Project' do
        f.input :children, as: :text
      end
      inputs 'Visuals' do
        f.input :background, as: :file
        f.input :display_mode, collection: %i(map panel), include_blank: false
        f.inputs :geomap_url, :geomap_lambda, :geomap_vshift,
                 :geomap_scale, :geomap_center_x, :geomap_center_y
      end
      inputs 'Audio' do
        f.input :play_mode
        f.inputs :bpm, :quantize
      end
    end
    f.actions
  end
end
