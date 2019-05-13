# frozen_string_literal: true

require 'kramdown'

class AudiosetsController < ApplicationController

  respond_to :html, :json

  def index
    @audiosets = Audioset.all
    respond_with @audiosets
  end

  def show
    disable_cors
    @audioset = Audioset.find_by(slug: params[:id])
  end

  private

  def disable_cors
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end

end
