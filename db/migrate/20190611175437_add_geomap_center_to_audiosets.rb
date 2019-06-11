# frozen_string_literal: true

class AddGeomapCenterToAudiosets < ActiveRecord::Migration[5.2]

  def change
    add_column :audiosets, :geomap_center_x, :float
    add_column :audiosets, :geomap_center_y, :float
  end

end
