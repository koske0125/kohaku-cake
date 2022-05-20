Rails.application.routes.draw do

  devise_for :customers, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  devise_for :admin, controllers: {
  sessions: "admin/sessions"
}

  namespace :public, path: "" do
    get '/' => 'homes#top'
    get '/about' => 'homes#about'
    get '/my_page' => 'customers#show'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
