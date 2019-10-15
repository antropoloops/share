# frozen_string_literal: true

ActiveAdmin.register Clip do
  config.sort_order = 'created_at desc'
  config.batch_actions = false
  permit_params :audioset_id, :track_id,
                :name, :title, :readme,
                :cover, :cover2, :audio_mp3, :audio_wav, :audio_ogg,
                :title, :artist, :year, :country,
                :place, :xpos, :ypos,
                :color, :key, :beats, :volume

  filter :audioset

  belongs_to :audioset

  index as: :grid, columns: 6 do |clip|
    render partial: 'clip', locals: { clip: clip }
  end

  show do
    div do
      image_tag(clip.cover_url(:small)) if clip.cover
    end
    attributes_table do
      row :audioset
      row :track
      row :name
      row :slug
      row :audio_mp3_url do |clip|
        clip.public_audio_url(:mp3) if clip.audio_mp3
      end
      row :audio_wav_url do |clip|
        clip.public_audio_url(:wav) if clip.audio_wav
      end
      row :audio_ogg_url do |clip|
        clip.public_audio_url(:ogg) if clip.audio_ogg
      end
      row :cover do |clip|
        clip.public_cover_url(:thumb) if clip.cover
      end
    end
    attributes_table do
      rows :title, :artist, :album, :year, :country, :place, :readme
      rows :xpos, :ypos
      rows :key, :beats, :volume
    end
    attributes_table do
      rows :cover_data, :audio_mp3_data, :audio_wav_data, :audio_ogg_data
    end
  end

  form do |f|
    f.inputs do
      inputs 'Clip' do
        f.input :track, collection: clip.audioset.tracks
        f.input :name
        f.input :readme, as: :text
        f.input :key
      end
      inputs 'Media files' do
        f.input :cover, as: :file
        f.input :cover2, as: :file
        f.input :audio_mp3, as: :file
        f.input :audio_wav, as: :file
        f.input :audio_ogg, as: :file
      end
      inputs 'Song information' do
        f.input :title
        f.input :artist
        f.input :album
        f.input :year
        f.input :country
        f.input :place
        f.input :xpos
        f.input :ypos
      end
      inputs 'Audio' do
        f.input :beats
        f.input :volume
      end
    end
    f.actions
  end
end
