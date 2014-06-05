Blog::Application.routes.draw do



  resources :messages

  resources :pic_comments

  get "sessions/create"
  get "sessions/destroy"
  resources :users

  resources :pictures

  resources :comments

 # get "blog/show"
  get "blog/index"
  #get "blog/post"
  # get "blog/gallery"
  # post "blog/gallery"
  # get "blog/album"
  
  get "blog/save"
  post "blog/save"
  get "blog/picture"
  post "blog/edit_category"
  get "blog/edit_category"
  get "blog/delete_article"
  get "blog/delete_comment"
  delete "blog/delete_picture"
  get "blog/edit_picture"
  patch "blog/update_picture"
  resources :articles


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'blog#index', as: 'blog'
  
  get 'blog' => 'blog#index'
  get 'blog/:name' => 'blog#index'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
    get 'register'
    get 'register_notice'
    get 'find_password'
    post 'send_mail'
    get 'reset_password'
    get 'new_password'
  end
  controller :categories do
    get 'blog/:name/categories' => 'categories#show', as: :category_show
  end
  controller :blog do
    get 'blog/:name/show' => 'blog#show', as: :article_show
    get "blog/:name/post" => 'blog#post', as: :article_post
    get "blog/:name/edit" => 'blog#edit_article', as: :article_edit
    get "blog/:name/archive" => 'blog#archive', as: :archive_show
    get "blog/:name/gallery" => 'blog#gallery', as: :gallery_show
    post "blog/:name/gallery" =>'blog#gallery', as: :gallery_post
    get "blog/:name/album" => 'blog#album', as: :album_show
    get "blog/:name/messages" => 'blog#message', as: :message_show
  end

  resources :tags
  #resources :categories

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
