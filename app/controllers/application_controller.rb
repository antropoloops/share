# frozen_string_literal: true

require 'application_responder'

class ApplicationController < ActionController::Base

  include Pundit
  protect_from_forgery with: :exception

  self.responder = ApplicationResponder
  respond_to :html, :json

end
