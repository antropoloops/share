# frozen_string_literal: true

ActiveAdmin.register Track do
  config.sort_order = 'position_asc'
  permit_params :position, :name, :color, :volume

  belongs_to :audioset

  form do |f|
    f.input :name
    f.input :color
    f.input :volume
    f.actions
  end
end
