defmodule Featureyard.Api.FeatureController do
  import Ecto.Query

  use Featureyard.Web, :controller

  alias Featureyard.Repo
  alias Featureyard.Feature
  alias Featureyard.Client

  def index(conn, _params) do
    key = conn |> get_req_header("x-api-key") |> Enum.at(0) || ""
    client = Repo.get_by!(Client, key: key)
    |> Repo.preload(:features)

    features = client.features
    render(conn, :index, features: features)
  end

end
