# frozen_string_literal: true

json.format 'atpls-audioset'
json.version '2.0.0'
json.id audioset.slug
json.type audioset.audioset_type
json.last_updated_at audioset.updated_at.to_i

json.meta do
  json.title audioset.name
  json.path audioset.publish_path
  json.parent_path audioset.parent.present? ? audioset.parent.publish_path : ''
  json.description audioset.description
  json.readme Kramdown::Document.new(audioset.readme).to_html
  json.logo_url audioset.public_logo_url(:small)
end

if audioset.project?
  json.audiosets audioset.project_children do |audioset|
    json.id audioset.id
    json.title audioset.name
    json.publish_path audioset.publish_path
    json.description audioset.description
    json.logo_url audioset.public_logo_url(:small)
  end
else
  json.audio do
    json.bpm audioset.bpm
    json.defaults do
      json.loop true
    end
    json.signature [4, 4]
    json.trackMaxVoices 1
    json.quantize audioset.quantize
  end

  json.visuals do
    json.mode audioset.display_mode || 'map'
    if audioset.background
      json.image do
        json.url audioset.background_url(public: true)
        json.size do
          json.width audioset.background_data['metadata']['width']
          json.height audioset.background_data['metadata']['height']
        end
      end
    end
    json.geomap do
      json.url audioset.geomap_url
      json.scaleFactor audioset.geomap_scale
      json.center do
        json.x audioset.geomap_center_x
        json.y audioset.geomap_center_y
      end
    end
  end

  json.tracks audioset.tracks.reorder(position: :asc), partial: 'tracks/track', as: :track
  json.clips audioset.clips, partial: 'clips/clip', as: :clip

end
