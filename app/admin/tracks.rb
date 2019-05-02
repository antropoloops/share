# frozen_string_literal: true

ActiveAdmin.register Track do
  permit_params :audioset_id, :position, :name, :color, :volume
end
