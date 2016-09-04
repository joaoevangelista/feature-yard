defmodule Featureyard.AudienceController do
  use Featureyard.Web, :controller

  alias Featureyard.Audience
  alias Featureyard.Feature
  alias Featureyard.Repo

  plug Guardian.Plug.EnsureAuthenticated, [handler: Featureyard.SessionController]

  def index(conn, %{"feature_id" => feature_id}) do
    feature = Repo.get!(Feature, feature_id)
    |> Repo.preload([:audiences, :client])
    render(conn, "index.html", feature: feature, audiences: feature.audiences)
  end

  def new(conn, %{"feature_id" => feature_id}) do
    feature = Repo.get!(Feature, feature_id) |> Repo.preload(:client)
    changeset = Audience.changeset(%Audience{feature_id: feature.id})
    render(conn, "new.html", changeset: changeset, feature: feature)
  end

  def create(conn, %{"audience" => audience_params, "client_id" => client_id, "feature_id" => feature_id}) do
    changeset = Audience.changeset(%Audience{}, audience_params)
    feature = Repo.get!(Feature, feature_id) |> Repo.preload(:client)
    case Repo.insert(changeset) do
      {:ok, audience} ->


        conn
        |> put_flash(:info, "Audience created successfully.")
        |> redirect(to: client_feature_audience_path(conn, :index, feature.client,
        feature))
        {:error, changeset} ->
          render(conn, "new.html", changeset: changeset, feature: feature)
        end
      end

  def show(conn, %{"id" => id}) do
    audience = Repo.get!(Audience, id)
    |> Repo.preload(:feature)
    feature =  Repo.preload(audience.feature, :client)
    render(conn, "show.html", audience: audience, feature: feature)
  end

  def edit(conn, %{"id" => id}) do
    audience = Repo.get!(Audience, id)
    |> Repo.preload(:feature)
    feature = Repo.preload(audience.feature, :client)
    changeset = Audience.changeset(audience)
    render(conn, "edit.html",
    audience: audience, feature: feature,
    changeset: changeset)
  end

  def update(conn, %{"id" => id, "audience" => audience_params}) do
    audience = Repo.get!(Audience, id) |> Repo.preload(:feature)
    changeset = Audience.changeset(audience, audience_params)

    case Repo.update(changeset) do
      {:ok, audience} ->
        loaded_audience = Repo.preload(audience, :feature)
        feature = Repo.preload(loaded_audience.feature, :client)

        conn
        |> put_flash(:info, "Audience updated successfully.")
        |> redirect(to: client_feature_audience_path(conn, :index,
        feature.client, feature))

      {:error, changeset} ->
        render(conn, "edit.html", audience: audience, feature: audience.feature, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    audience = Repo.get!(Audience, id)
    |> Repo.preload(:feature)
    feature =  Repo.preload(audience.feature, :client)
    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(audience)
    conn
    |> put_flash(:info, "Audience deleted successfully.")
    |> redirect(to: client_feature_audience_path(conn, :index,
    feature.client, feature))
  end
end
