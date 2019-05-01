# frozen_string_literal: true

class SpacesController < ApplicationController

  before_action :authenticate_user!

  respond_to :html

  def index
    @spaces = current_user.spaces
    respond_with(@spaces)
  end

  def show
    @space = current_user.spaces.find_by(slug: params[:id])
    @asset = @space.assets.new
    respond_with(@space)
  end

end
