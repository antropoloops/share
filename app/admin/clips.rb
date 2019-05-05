# frozen_string_literal: true

ActiveAdmin.register Clip do
  config.sort_order = 'created_at desc'
  permit_params :audioset_id, :track_id,
                :name, :title, :readme,
                :cover, :audio,
                :title, :artist, :year, :country,
                :place, :xpos, :ypos,
                :color, :key, :beats, :volume

  filter :audioset

  belongs_to :audioset
  controller do
  end

  index do
    column :cover do |clip|
      image_tag(clip.public_cover_url(:thumb)) if clip.cover
    end
    column :audioset do |clip|
      clip.audioset.name
    end
    column :track
    column :slug
    column :title
    column :artist
    column :year
    column :country
    actions
  end

  show do
    h3 do
      link_to "👉 Go to '#{clip.audioset.name}'",
              admin_audioset_path(clip.audioset)
    end
    h3 do
      link_to "👉 Go to '#{clip.audioset.name}' clips",
              admin_audioset_clips_path(clip.audioset)
    end
    attributes_table do
      row :audioset
      row :track
      row :name
      row :slug
      row :image_url do |clip|
        clip.public_cover_url(:thumb) if clip.cover
      end
      row :audio_mp3_url do |clip|
        clip.public_audio_url(:mp3) if clip.audio_mp3
      end
      row :audio_wav_url do |clip|
        clip.public_audio_url(:wav) if clip.audio_wav
      end
      row :image do |clip|
        image_tag(clip.cover_url(:small)) if clip.cover
      end
      rows :title, :artist, :year, :country, :place, :xpos, :ypos
      rows :color, :key, :beats, :volume
    end
  end

  form do |f|
    f.inputs do
      inputs 'Clip' do
        f.input :track, collection: clip.audioset.tracks
        f.input :name
        f.input :readme, as: :text
      end
      inputs 'Media files' do
        f.input :cover, as: :file
      end
      inputs 'Song information' do
        f.input :title
        f.input :artist
        f.input :year
        f.input :country
        f.input :place
        f.input :xpos
        f.input :ypos
      end
      inputs 'Meta' do
        f.input :color, as: :string
        f.input :key
        f.input :beats
        f.input :volume
      end
    end
    f.actions
  end
end
