defmodule Featureyard.Api.FeatureController do
  import Ecto.Query

  use Featureyard.Web, :controller

  alias Featureyard.Repo
  alias Featureyard.Client

  plug :ensure_api_key

  @token_header "x-token"

  def index(conn, _params) do
    case conn |> get_req_header(@token_header) |> Enum.at(0, "") |> Base.decode64 do
      {:ok, key} ->
        client = Repo.get_by!(Client, key: key)
        |> Repo.preload(:features)
        features = Repo.preload(client.features, :audiences)
        render(conn, :index, features: features)
      {:error} ->
        render(conn, "error.json")
    end
  end


  def ensure_api_key(conn, _options) do
     header = conn |> get_req_header(@token_header)
     if Enum.at(header, 0) != nil do
       conn
     else
       conn |> send_resp(401, "")
     end
  end
end
