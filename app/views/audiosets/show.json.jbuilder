# frozen_string_literal: true

json.version '2.0.0'
json.partial! 'audiosets/audioset', audioset: @audioset
json.tracks @audioset.tracks, partial: 'tracks/track', as: :track
json.clips @audioset.clips, partial: 'clips/clip', as: :clip
