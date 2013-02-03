# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
RedmineApp::Application.routes.draw do
	resources :announcements do
			collection do
				get 'hide_announcement'
			end
	end
	
	match 'announcements/:id' => "announcements#show", :via => :get
end

