# frozen_string_literal: true

json.extract! asset, :id, :file, :space_id, :created_at, :updated_at
json.url asset_url(asset, format: :json)
