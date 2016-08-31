defmodule Featureyard.FeatureController do
  use Featureyard.Web, :controller

  alias Featureyard.Feature
  alias Featureyard.Client

  plug Addict.Plugs.Authenticated when action in [:new, :create, :edit, :update, :delete]
  plug :action

  def new(conn, %{"client_id" => client_id}) do
    client = Repo.get!(Client, client_id)
    changeset = Feature.changeset(%Feature{client_id: client.id})
    render(conn, "new.html", changeset: changeset, client: client)
  end

  def create(conn, %{"feature" => feature_params, "client_id" => client_id}) do
    changeset = Feature.changeset(%Feature{}, feature_params)

    case Repo.insert(changeset) do
      {:ok, feature} ->
        loaded = Repo.preload(feature, :client)
        conn
        |> put_flash(:info, "Feature created successfully.")
        |> redirect(to: client_path(conn, :show, loaded.client.id))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset,
         client: %Client{id: client_id})
    end
  end

  def edit(conn, %{"id" => id, "client_id" => client_id}) do
    feature = Repo.get!(Feature, id) |> Repo.preload(:client)
    changeset = Feature.changeset(feature)
    render(conn, "edit.html", feature: feature, changeset: changeset, client: %Client{id: client_id})
  end

  def update(conn, %{"id" => id, "client_id" => client_id, "feature" => feature_params}) do
    feature = Repo.get!(Feature, id)
    changeset = Feature.changeset(feature, feature_params)

    case Repo.update(changeset) do
      {:ok, feature} ->
        loaded = Repo.preload feature, :client
        conn
        |> put_flash(:info, "Feature updated successfully.")
        |> redirect(to: client_path(conn, :show, loaded.client))
      {:error, changeset} ->
        render(conn, "edit.html", feature: feature,
         changeset: changeset, client: %Client{id: client_id})
    end
  end

  def delete(conn, %{"id" => id}) do
    feature = Repo.get!(Feature, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(feature)

    conn
    |> put_flash(:info, "Feature deleted successfully.")
    |> redirect(to: client_path(conn, :index, feature.client_id))
  end
end
