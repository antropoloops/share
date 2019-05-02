# frozen_string_literal: true

ActiveAdmin.register Clip do
  permit_params :audioset_id,
                :name, :title, :readme,
                :cover, :audio,
                :title, :artist, :year, :country,
                :place, :xpos, :yposm,
                :color, :key, :beats, :volume

  filter :audioset

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
    attributes_table do
      row :audioset
      row :slug
      row :image_url do |clip|
        clip.public_cover_url(:thumb) if clip.cover
      end
      row :audio_mp3_url do |clip|
        link_to clip.public_audio_url(:mp3), clip.public_audio_url(:mp3)
      end
      row :audio_wav_url do |clip|
        clip.public_audio_url(:wav)
      end
      row :image do |clip|
        image_tag(clip.cover_url(:small)) if clip.cover
      end
    end
    attributes_table_for clip do
      rows :title, :artist, :year, :country, :place, :xpos, :ypos
      rows :color, :key, :beats, :volume
    end
  end

  form do |f|
    f.inputs do
      inputs 'Clip' do
        f.input :audioset
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
