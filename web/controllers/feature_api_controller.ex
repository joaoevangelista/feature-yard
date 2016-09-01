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
        features = client.features
        render(conn, :index, features: features)
      {:error, _reason} ->
        render(conn, "error.json")
    end
  end
end
