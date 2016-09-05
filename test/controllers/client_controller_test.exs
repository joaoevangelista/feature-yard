defmodule Featureyard.ClientControllerTest do
  use Featureyard.ConnCase

  alias Featureyard.Client

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} = config do
    cond do
      config[:login] ->
        user = insert(:user)
        signed_in = put_in(conn.secret_key_base, @secret)
        |> Plug.Session.call(@signing_opts)
        |> Plug.Conn.fetch_session
        |> Guardian.Plug.sign_in(user, :token)
        {:ok, conn: signed_in}
        true ->
          :ok
      end
  end


  @tag :login
  test "lists all entries on index", %{conn: conn} do
    conn = get conn, client_path(conn, :index)
    assert html_response(conn, 200) =~ "My Clients"
  end

  @tag :login
  test "renders form for new resources", %{conn: conn} do
    conn = get conn, client_path(conn, :new)
    assert html_response(conn, 200) =~ "Add client"
  end

  @tag :login
  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, client_path(conn, :create), client: @valid_attrs
    assert redirected_to(conn) == client_path(conn, :index)
    assert Repo.get_by(Client, @valid_attrs)
  end

  @tag :login
  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, client_path(conn, :create), client: @invalid_attrs
    assert html_response(conn, 200) =~ "Add client"
  end

  @tag :login
  test "shows chosen resource", %{conn: conn} do
    client = Repo.insert! %Client{}
    conn = get conn, client_path(conn, :show, client)
    assert html_response(conn, 200) =~ "Client Key"
  end

  @tag :login
  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
    get conn, client_path(conn, :show, -1)
    end
  end

  @tag :login
  test "renders form for editing chosen resource", %{conn: conn} do
    client = Repo.insert! %Client{}
    conn = get conn, client_path(conn, :edit, client)
    assert html_response(conn, 200) =~ "Edit client"
  end

  @tag :login
  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    client = Repo.insert! %Client{}
    conn = put conn, client_path(conn, :update, client), client: @valid_attrs
    assert redirected_to(conn) == client_path(conn, :show, client)
    assert Repo.get_by(Client, @valid_attrs)
  end

  @tag :login
  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    client = Repo.insert! %Client{}
    conn = put conn, client_path(conn, :update, client), client: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit client"
  end

  @tag :login
  test "deletes chosen resource", %{conn: conn} do
    client = Repo.insert! %Client{}
    conn = delete conn, client_path(conn, :delete, client)
    assert redirected_to(conn) == client_path(conn, :index)
    refute Repo.get(Client, client.id)
  end
end
