defmodule GradeKings.Router do
  use GradeKings.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GradeKings do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources "registration", RegistrationController, only: [:new, :create]
    resources "bgs", BgsController
    resources "cbcs", CbcsController

    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", GradeKings do
  #   pipe_through :api
  # end
end
