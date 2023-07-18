defmodule CommonComponents.Repo do
  use Ecto.Repo,
    otp_app: :common_components,
    adapter: Ecto.Adapters.Postgres
end
