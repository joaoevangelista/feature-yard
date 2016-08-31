defmodule Featureyard.FeatureAPIController do
  import Ecto.Query

  use Featureyard.Web, :controller

  alias Featureyard.Repo
  alias Featureyard.Feature
  alias Featureyard.Client

  def fetch_features_for_client(conn, _params) do
    key = conn |> get_req_header("x-api-key") |> Enum.at(0) || ""
    client = Repo.get_by!(Client, key: key)
    |> Repo.preload(:features)
    render conn, features: client.features

  end

end
