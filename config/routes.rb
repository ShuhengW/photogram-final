Rails.application.routes.draw do
  resources :comments
  # Routes for the Photo resource:

  # CREATE
  post("/insert_photo", { :controller => "photos", :action => "create" })
          
  # READ
  get("/photos", { :controller => "photos", :action => "index" })
  
  get("/photos/:path_id", { :controller => "photos", :action => "show" })
  
  # UPDATE
  
  post("/modify_photo/:path_id", { :controller => "photos", :action => "update" })
  
  # DELETE
  get("/delete_photo/:path_id", { :controller => "photos", :action => "destroy" })

  #------------------------------

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root to: "user#index"
  get("/", { :controller => "users", :action => "index" })
  get("/users", { :controller => "users", :action => "index" })
  get("/users/:username", { :controller => "users", :action => "show" })
  post("/insert_follow_request", { :controller => "users", :action => "create_follow_request" })
  get("/delete_follow_request/:path_id", { controller: "users", action: "destroy_follow_request" })
  post("modify_follow_request/:path_id", { controller: "users", action: "update_follow_request" })

  post("/insert_like", { :controller => "likes", :action => "create" })
  get("/delete_like/:path_id", { :controller => "likes", :action => "destroy" })

  get("/users/:username/feed", { :controller => "users", :action => "feed" })
end
