# frozen_string_literal: true

class AssetsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_space
  before_action :set_asset, only: %i(show edit update destroy)

  respond_to :html

  def edit; end

  def create
    @asset = Asset.new(asset_params)
    @asset.save
    respond_with(@asset)
  end

  def update
    @asset.update(asset_params)
    respond_with(@asset)
  end

  def destroy
    @asset.destroy
    respond_with(@asset)
  end

  private

  def set_space
    @space = Space.find(params[:space_id])
  end

  def set_asset
    @asset = Asset.find(params[:id])
  end

  def asset_params
    params.require(:asset).permit(:file, :description, :space_id)
  end

end
