# frozen_string_literal: true

ActiveAdmin.register Geomap do
  permit_params :name, :map, :lambda, :vshift, :hshift, :scale

  show do
    attributes_table do
      row :name
      row :map do |geomap|
        link_to geomap.map_url(public: true), geomap.map_url(public: true)
      end
      row :map_data
      rows :lambda, :vshift, :hshift, :scale
    end
  end

  form do |f|
    f.semantic_errors
    f.input :name
    f.input :map, as: :file
    inputs 'Meta' do
      f.inputs :lambda, :vshift, :hshift, :scale
    end
    f.actions
  end
end
