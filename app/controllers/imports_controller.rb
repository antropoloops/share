# frozen_string_literal: true

class ImportsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def audioset
    audioset = Audioset.new(audioset_params)
    audioset.save!
    render json: audioset
  end

  def track
    audioset = Audioset.find(params[:audioset_id])
    track = audioset.tracks.build(track_params)
    track.save
    render json: track
  end

  def media
    clip = Clip.find(params[:clip_id])
    clip.cover_remote_url = params[:cover_url] if params[:cover_url].present?
    clip.audio_mp3_remote_url = params[:audio_mp3_url] if params[:audio_mp3_url].present?
    clip.audio_mp3 = nil if params[:audio_mp3_destroy].present?
    clip.audio_wav_remote_url = params[:audio_wav_url] if params[:audio_wav_url].present?
    clip.save
    render json: clip
  end

  def clip
    audioset = Audioset.find(params[:audioset_id])
    track = Track.find(params[:track_id])
    clip = audioset.clips.build(clip_params)
    clip.track = track
    clip.save!
    render json: clip
  end

  private

  def audioset_params
    params.require(:audioset).permit(:name, :description, :readme)
  end

  def track_params
    params.require(:track).permit(:name, :position, :color, :volume)
  end

  def clip_params
    params.require(:clip).permit(:name, :title,
                                 :album, :artis, :year, :country,
                                 :xpos, :ypos, :readme, :color, :key, :beats, :volume)
  end

end
