# frozen_string_literal: true

ActiveAdmin.setup do |config|
  config.site_title = 'Antropoloops'

  config.authentication_method = :authenticate_admin_user!
  config.current_user_method = :current_admin_user
  config.logout_link_path = :destroy_admin_user_session_path

  config.localize_format = :long
  config.footer = '_a_t_p_l_s_'

  config.comments = false
  config.batch_actions = true

  # Artic theme configuration
  # https://github.com/cprodhomme/arctic_admin#installation
  meta_tags_options = { viewport: 'width=device-width, initial-scale=1' }
  config.meta_tags = meta_tags_options
  config.meta_tags_for_logged_out_pages = meta_tags_options

  # == Friendly Id addon
  ActiveAdmin::ResourceController.class_eval do
    def find_resource
      resource_class.is_a?(FriendlyId) ? scoped_collection.friendly.find(params[:id]) : scoped_collection.find(params[:id])
    end
  end
end