defmodule DevicesAPIWeb.Router do
  use DevicesAPIWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", DevicesAPIWeb do
    pipe_through :api
  end

  scope "/", DevicesApiWeb do
    post "/users/signup", UsersController, :create
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: DevicesAPIWeb.Telemetry
    end
  end
end
