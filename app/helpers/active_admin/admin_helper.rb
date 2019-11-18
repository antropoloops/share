# frozen_string_literal: true

module ActiveAdmin::AdminHelper
  def player_path(audioset)
    "https://play.antropoloops.com/set/#{audioset.publish_path}"
  end

  def player_url(audioset)
    "https://play.antropoloops.com/set?url=#{audioset_url(audioset, format: :json)}"
  end

  def staging_player_url(audioset)
    "https://play-staging.antropoloops.com/test?url=#{audioset_url(audioset, format: :json)}"
  end
end
