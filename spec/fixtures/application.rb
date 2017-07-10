require 'active_support/all'
require 'action_controller'
require 'action_dispatch'

module Rails
  class App
    def env_config
      {}
    end

    def routes
      return @routes if defined?(@routes)
      @routes = ActionDispatch::Routing::RouteSet.new
      @routes.draw do
        resources :posts do
          get :custom, on: :collection
        end
        resources :welcome
      end
      @routes
    end
  end

  def self.application
    @app ||= App.new
  end

  def self.env
    'test'
  end
end
