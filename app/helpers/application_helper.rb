# frozen_string_literal: true

module ApplicationHelper
  def player_url(audioset)
    "https://play.antropoloops.com/test?url=#{audioset_url(audioset, format: :json)}"
  end
end
