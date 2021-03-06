MathWorld::Application.routes.draw do

  match "documents/search" => "documents#search"
  match "documents/:id/comment" => "documents#addcomment", :via => [:post]
  match "documents/:id/rating" => "documents#addrating", :via => [:post]
  resources :documents
  
=begin
The next routes are for the users controller.  These handle
the user management tasks.  Users are well-modeled as a 
RESTful resource  
=end 
  match "users/new" => "users#new"
# Note that the form_for construct we're using will
# automagically set the method to post or put as appropriate
# The update and create matches must come before index,
# which will catch all other methods.
  match "users" => "users#update", :via => [:put]
  match "users" => "users#create", :via => [:post]
  match "users" => "users#index"
  match "users/:id" => "users#show", :via => [:get]
  match "users/:id/edit" => "users#edit" , :via => [:get]
  match "users/:id/destroy" => "users#destroy"

=begin
Create the routing for signin/session management.  A session
can be treated as another RESTFUL resource, just one without
persistent storage in the database
=end
  match 'welcome/login' => 'sessions#showsignin', :via => [:get]
  match 'sessions' => 'sessions#showsignin', :via => [:get]
  match 'sessions' => 'sessions#login', :via => [:post]
  match 'sessions/logout' => 'sessions#logout'

  get "welcome/index"

  get "math_content/public"

  get "math_content/teacher"

  get "math_content/student"
 
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
