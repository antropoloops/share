# frozen_string_literal: true

ActiveAdmin.register Track do
  config.sort_order = 'position_asc'
  permit_params :position, :name, :color, :volume

  belongs_to :audioset

  index as: :grid, columns: 6 do |track|
    render partial: 'track', locals: { track: track }
  end

  form do |f|
    f.input :name
    f.input :color
    f.input :position
    f.input :volume
    f.actions
  end
end
