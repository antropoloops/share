# frozen_string_literal: true

json.id track.slug
json.extract! track, :name, :color, :volume, :position
json.clipIds track.clips.map(&:slug)
