module ApplicationHelperPatch
  
  def self.included(base)
    base.send(:include, InstanceMethods)
  end	
  
  module InstanceMethods

    def current_announcements
      @current_announcements ||= Announcement.current_announcements(session[:announcement_hide_time])
    end

  end # Instance Methods	

end

unless ApplicationHelper.included_modules.include?(ApplicationHelperPatch)
  ApplicationHelper.send(:include, ApplicationHelperPatch)
end
