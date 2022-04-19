defmodule Huzzah.Repo do
  use Ecto.Repo,
    otp_app: :huzzah,
    adapter: Ecto.Adapters.Postgres
end
