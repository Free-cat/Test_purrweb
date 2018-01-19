Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'authors/create', to: 'author#create'
  get 'authors/list', to: 'author#list'
  get 'authors/:id', to: 'author#show'

  post 'categories/create', to: 'category#create'
  get 'categories/list', to: 'category#list'

  post 'articles/create', to: 'article#create'
  get 'articles/by_author', to: 'article#by_author'
  get 'articles/by_category', to: 'article#by_category'
  get 'articles/by_tag', to: 'article#by_tag'
  get 'articles/today', to: 'article#today'
  get 'articles/:id', to: 'article#show'
end
