defmodule Mechat.Web.Router do
  use Mechat.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/api", Mechat.Web do
    pipe_through :api

    post "/sessions", SessionController, :create
    delete "/sessions", SessionController, :delete
    post "/sessions/refresh", SessionController, :refresh
    resources "/users", UserController, only: [:create]
    get "/dialogs", DialogController, :index
    get "/messages/:username", MessageController, :show
    delete "/messages/:id", MessageController, :delete
    post "/messages/:username", MessageController, :create
    # post "/messages/read/:message_list", :read_messages
 
    # resources "/dialogs", DialogController, except: [:new, :edit]
    # resources "/messages", MessageController, except: [:new, :edit]
    # resources "/user_message", UserMessageController, except: [:new, :edit]
  end

  scope "/", Mechat.Web do
    pipe_through :browser # Use the default browser stack

    get "/*path", PageController, :index
  end
end
