defmodule WebPoker.Endpoint do
  use Phoenix.Endpoint, otp_app: :web_poker

  plug Plug.Static,
    at: "/", from: :web_poker

  plug Plug.Logger

  # Code reloading will only work if the :code_reloader key of
  # the :phoenix application is set to true in your config file.
  plug Phoenix.CodeReloader

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_web_poker_key",
    signing_salt: "doNaia/4",
    encryption_salt: "WginzjKT"

  plug :router, WebPoker.Router
end
