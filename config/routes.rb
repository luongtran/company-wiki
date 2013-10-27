CompanyWiki::Application.routes.draw do
  
  root to: 'home#index'
  
   # get '/roots/:p_id' => 'admin/subjects#roots'
   # get '/childrens-of/:p_id' => 'admin/subjects#childrens_of'
   # get '/subject-infor/:p_id' => 'admin/subjects#subject_infor'
   # post '/reorder'=>  'admin/subjects#reorder'
   
   get '/subjects/:id' => "subjects#show", :as => :subject
   
   #get '/subjects/:subject_id/posts' => "posts#index", :as => :posts
   get '/subjects/:subject_id/posts/new' => "posts#new", :as => :new_post
   post '/subjects/:subject_id/posts/create' => "posts#create", :as => :subject_posts
   get '/subjects/:subject_id/posts/:id' => "posts#show", :as => :subject_post
   
   delete '/subjects/:subject_id/posts/:id' => "posts#destroy", :as => :subject_post
   
   get '/subjects/:subject_id/posts/:id/edit' => "posts#edit", :as => :subject_post_edit
   
   put 'subjects/:subject_id/posts/:id' => "posts#update", :as => :subject_post_update
   
   post '/subjects/:subject_id/posts/:post_id/comments' => "comments#create", :as => :subject_post_comments
   
   get "/feed" => "activities#feed", as: :feed
    get "/feed/fetch" => "activities#show", as: :fetch_activity
  
    get "/yours" => "activities#yours", as: :your_actions
  
    
   get "/no-permission" => "home#no_permission", :as => :no_permission
  
  devise_for :users

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  get "/my-page" => "activities#yours", :as => :my_page
  get "/:id" => "users#show", as: :user
  match "users/:id/update-avatar" => "users#ajax_update_avatar", :as => :user_update_avatar
  match "users/:id/update-profile" => "users#user_update_profile", :as => :user_update_profile
  

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
