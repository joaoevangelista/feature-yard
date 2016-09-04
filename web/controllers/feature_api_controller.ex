defmodule Featureyard.Api.FeatureController do
  import Ecto.Query

  use Featureyard.Web, :controller

  alias Featureyard.Repo
  alias Featureyard.Client

  def index(conn, _params) do
    case conn |> get_req_header("x-token") |> Enum.at(0, "") |> Base.decode64 do
      {:ok, key} ->
        client = Repo.get_by!(Client, key: key)
        |> Repo.preload(:features)
        features = Repo.preload(client.features, :audiences)
        render(conn, :index, features: features)
      {:error} ->
        render(conn, "error.json")
    end
  end
end
