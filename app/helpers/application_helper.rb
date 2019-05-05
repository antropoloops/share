# frozen_string_literal: true

module ApplicationHelper
  def player_url(audioset)
    "https://play.antropoloops.com/test?#{audioset.id}"
  end
end
