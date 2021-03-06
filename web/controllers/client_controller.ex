defmodule Featureyard.ClientController do
  use Featureyard.Web, :controller

  alias Featureyard.Client

  plug Guardian.Plug.EnsureAuthenticated, [handler: Featureyard.SessionController]

  def index(conn, _params) do
    clients = Repo.all(Client)
    render(conn, "index.html", clients: clients)
  end

  def new(conn, _params) do
    changeset = Client.changeset(%Client{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"client" => client_params}) do
    changeset = Client.changeset(%Client{}, client_params)

    case Repo.insert(changeset) do
      {:ok, _client} ->
        conn
        |> put_flash(:info, "Client created successfully.")
        |> redirect(to: client_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    client = Repo.get!(Client, id)
    client_key = Base.encode64(client.key)
    render(conn, "show.html", client: client, base64_key: client_key)
  end

  def edit(conn, %{"id" => id}) do
    client = Repo.get!(Client, id)
    changeset = Client.changeset(client)
    render(conn, "edit.html", client: client, changeset: changeset)
  end

  def update(conn, %{"id" => id, "client" => client_params}) do
    client = Repo.get!(Client, id)
    changeset = Client.changeset(client, client_params)

    case Repo.update(changeset) do
      {:ok, client} ->
        conn
        |> put_flash(:info, "Client updated successfully.")
        |> redirect(to: client_path(conn, :show, client))
      {:error, changeset} ->
        render(conn, "edit.html", client: client, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    client = Repo.get!(Client, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(client)

    conn
    |> put_flash(:info, "Client deleted successfully.")
    |> redirect(to: client_path(conn, :index))
  end

  # PUT /clients/1/key
  def reset_key(conn, %{"id" => id}) do
    client = Repo.get! Client, id
    changeset = Client.changeset(client, %{key: UUID.uuid1()})
    case Repo.update(changeset) do
      {:ok, saved_client} ->
        conn
        |> put_flash(:info, "Client key regenerated successfully.")
        |> redirect(to: client_path(conn, :show, saved_client))
      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Failed to regeneted key.")
        |> redirect(to: client_path(conn, :show, client))
    end
  end
end
