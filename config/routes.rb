Rails.application.routes.draw do
  # keep this on top
  match '/cable', to: ActionCable.server, via: [:get, :post]
  # mount ActionCable.server => '/cable'

  namespace :v1, except: [:new, :edit], format: :json do
    get :activities, to: 'activities#filter', constraints: ->(request) { request.params.key? :filter }
    resources :activities # , only: [:show, :index]

    get :users, to: 'users#filter', constraints: ->(request) { request.params.key? :filter }
    resources :users, except: [:new, :edit, :destroy] do
      get :current, on: :collection
    end

    namespace :engines do
      BEPStore.constants.each do |engine|
        mount BEPStore.const_get(engine)::Engine => "/#{engine.to_s.underscore}" unless engine == :Application
      end
    end
  end

  root to: redirect { Rails.application.config_for(:app)[:ui_url] }
end
