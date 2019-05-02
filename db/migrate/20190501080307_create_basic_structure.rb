# frozen_string_literal: true

class CreateBasicStructure < ActiveRecord::Migration[5.2]

  def change
    create_table :assets, id: :uuid do |t|
      t.string :name, null: false, uniqueness: true
      t.string :slug, null: false, uniqueness: true
      t.text :description
      t.jsonb :file_data

      t.timestamps
    end

    create_table :geomaps, id: :uuid do |t|
      t.string :name, null: false, uniqueness: true
      t.string :slug, null: false, uniqueness: true
      t.jsonb :map_data
      t.float :lambda
      t.float :vshift
      t.float :hshift
      t.float :scale
      t.timestamps
    end

    create_table :audiosets, id: :uuid do |t|
      t.string :name, null: false, uniqueness: true
      t.string :slug, null: false, uniqueness: true

      # Meta
      t.string :description
      t.string :readme

      # Visuals
      t.references :geomap, foreign_key: true, type: :uuid
      t.jsonb :logo_data
      t.jsonb :background_data
      t.string :display_mode

      # Audio
      t.float :bpm
      t.integer :quantize
      t.string :play_mode

      t.timestamps
    end
    add_index :audiosets, :slug, unique: true

    create_table :tracks, id: :uuid do |t|
      t.references :audioset, foreign_key: true, type: :uuid
      t.integer :position, null: false, default: 0
      t.string :name, null: false
      t.string :slug, null: false
      t.string :color
      t.float :volume
      t.timestamps
    end
    add_index :tracks, %i(audioset_id position), unique: true
    add_index :tracks, %i(audioset_id slug), unique: true

    create_table :clips, id: :uuid do |t|
      t.references :audioset, foreign_key: true, type: :uuid
      t.references :track, foreign_key: true, type: :uuid
      t.string :name, null: false
      t.string :slug, null: false

      t.jsonb :cover_data
      t.jsonb :audio_mp3_data
      t.jsonb :audio_wav_data

      t.string :description
      t.string :title
      t.string :album
      t.string :artist
      t.string :year
      t.string :country
      t.string :place
      t.string :readme

      # lng
      t.float :xpos
      # lat
      t.float :ypos

      t.string :color
      t.string :key
      t.float :beats
      t.float :volume
      t.timestamps
    end
    add_index :clips, %i(audioset_id slug), unique: true
  end

end
