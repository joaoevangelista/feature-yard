defmodule Featureyard.Router do
  use Featureyard.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Featureyard do
    pipe_through [:browser, :browser_session]

    get "/", PageController, :index

    get    "/sign_in" , SessionController, :new   , as: :sign_in
    post   "/sign_in" , SessionController, :create, as: :sign_in

    get    "/sign_out", SessionController, :delete, as: :sign_out
    delete "/sign_out", SessionController, :delete, as: :sign_out

    get    "/sign_up" , UserController, :new   , as: :sign_up
    post   "/sign_up" , UserController, :create, as: :sign_up

    get    "/user"   , UserController, :show  , as: :user

    put    "/clients/:id/key", ClientController, :reset_key, as: :reset_key
    resources "/clients", ClientController do
      resources "/features", FeatureController, except: [:show] do
        resources "/audiences", AudienceController
      end
    end
  end

  # Other scopes may use custom stacks.
  scope "/api", Featureyard do
    pipe_through :api

    get "/features", Api.FeatureController, :index
  end
end
