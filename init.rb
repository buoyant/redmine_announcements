Rails.logger.info 'Starting Announcememts plugin for RedMine'
require 'redmine'

Redmine::Plugin.register :redmine_announcements do
  name 'Announcements'
  author 'Sandeep Kumar / sandeepleo11'
  description 'Site wide announcements plugin for Redmine'
  version '1.0'

  # This plugin adds a project module
  # It can be enabled/disabled at project level (Project settings -> Modules)
  project_module :announcements do
    permission :announcements, :announcements => :index
  end

  # A new item is added to the project menu
  menu :project_menu, :announcements, { :controller => 'announcements', :action => 'index' }, :caption => :label_announcements, :before => :settings, :param => :project_id

end


require 'application_helper_patch'
ActionDispatch::Callbacks.to_prepare do 
ApplicationHelper.send(:include, ApplicationHelperPatch) unless ApplicationHelper.included_modules.include? ApplicationHelperPatch
end

class RedmineAnnouncementsHook < Redmine::Hook::ViewListener
  render_on :view_layouts_base_content, :partial => 'announcements'
end
