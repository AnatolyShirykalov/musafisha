require 'rails_admin/custom_show_in_app'

RailsAdminSettings.track_history!

RailsAdmin.config do |config|
  config.parent_controller = '::ApplicationController'

  ## == Devise ==
  # this is required if not using cancan
  #config.authenticate_with do
    #warden.authenticate! scope: :user
  #end
  
  config.current_user_method(&:current_user)
  
  ## == Cancan ==
  config.authorize_with :cancan

  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version'



  config.actions do
    dashboard # mandatory

    # collection actions
    index
    new
    export
    bulk_delete

    # member actions
    show
    edit
    delete

    history_index
    history_show

    nested_set do
      visible do
        ['Page', 'Slide', 'Partner'].include? bindings[:abstract_model].model_name
      end
    end
    
    custom_show_in_app do
      visible do
        ['Page', 'News'].include? bindings[:abstract_model].model_name
      end
    end
    
    toggle
    toggle_menu do
      visible do
        ['Page'].include? bindings[:abstract_model].model_name
      end
    end
  end

  config.main_app_name = ['Musafisha', 'Админка']

  config.excluded_models = [
      'RailsAdmin::CustomShowInApp', 'HistoryTracker',
      'Ckeditor::Asset', 'Ckeditor::AttachmentFile', 'Ckeditor::Picture',
  ]
end

# [required] fix for timezones to be displayed in local time instead of UTC
module RailsAdmin
  module Config
    module Fields
      module Types
        class Datetime
          def value
            bindings[:object].send(name)
          end
        end
      end
    end
  end
end
