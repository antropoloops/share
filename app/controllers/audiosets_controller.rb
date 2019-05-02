# frozen_string_literal: true

class AudiosetsController < ApplicationController

  respond_to :html, :json

  def index
    @audiosets = Audioset.all
    respond_with @audiosets
  end

  def show
    @audioset = Audioset.find_by(slug: params[:id])
  end

end
