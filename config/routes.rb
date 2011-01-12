ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"



  # hook up '' for root
  map.connect '', :controller => "admin"

  # admin, design, credits and user routes have priority
  map.connect 'admin/:action', :controller => "admin"
  map.connect 'design/:action', :controller => "design"
  map.connect 'admin/:url_name/:action', :controller => "admin"
  map.connect 'admin/:url_name/:version/:action', :controller => "admin"

  map.connect 'user/:action/:id', :controller => "user"

  # rss results
  map.resources :responses
  map.resources :answers
  

  # route for published surveys
  map.connect ':account_name/:survey_url_name', :controller => 'public', :action => 'show_survey'
  map.connect ':account_name/:survey_url_name/thankyou', :controller => 'public', :action => 'thankyou'
  map.connect ':account_name/:survey_url_name/embed', :controller => 'public', :action => 'embed_survey'
  map.connect ':account_name/:survey_url_name/embedded_thankyou', :controller => 'public', :action => 'embedded_thankyou'

  # default route as the lowest priority.
  map.connect ':controller/:action/:id'

  map.home '', :controller => 'admin', :action => 'index'





end
