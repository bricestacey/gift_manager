GiftManager::Application.routes.draw do
  devise_for :users, path_names: {sign_in: 'signin', sign_out: 'signout'}

  resources :users
  resources :books do
    put "batch", on: :collection, controller: "books/batch", action: :update, as: 'batch'
    put "recommend", on: :member, controller: "books/recommendation", action: :update, as: 'recommend'
  end
  resources :bins
  resources :donors

  root to: "pages#home"
end
