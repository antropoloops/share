# frozen_string_literal: true

class AddGeomapToAudiosets < ActiveRecord::Migration[5.2]

  def change
    add_column :audiosets, :geomap_url, :string
    add_column :audiosets, :geomap_lambda, :float
    add_column :audiosets, :geomap_vshift, :float
    add_column :audiosets, :geomap_hshift, :float
    add_column :audiosets, :geomap_scale, :float
  end

end
