defmodule Featureyard.FeatureControllerTest do
  use Featureyard.ConnCase

  alias Featureyard.Feature
  @valid_attrs %{enabled: true, key: "some content", name: "some content"}
  @invalid_attrs %{enabled: true}

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
    conn = get conn, feature_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing features"
  end

  @tag :login
  test "renders form for new resources", %{conn: conn} do
    conn = get conn, feature_path(conn, :new)
    assert html_response(conn, 200) =~ "New feature"
  end

  @tag :login
  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, feature_path(conn, :create), feature: @valid_attrs
    assert redirected_to(conn) == feature_path(conn, :index)
    assert Repo.get_by(Feature, @valid_attrs)
  end

  @tag :login
  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, feature_path(conn, :create), feature: @invalid_attrs
    assert html_response(conn, 200) =~ "New feature"
  end

  @tag :login
  test "shows chosen resource", %{conn: conn} do
    feature = Repo.insert! %Feature{}
    conn = get conn, feature_path(conn, :show, feature)
    assert html_response(conn, 200) =~ "Show feature"
  end

  @tag :login
  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, feature_path(conn, :show, -1)
    end
  end

  @tag :login
  test "renders form for editing chosen resource", %{conn: conn} do
    feature = Repo.insert! %Feature{}
    conn = get conn, feature_path(conn, :edit, feature)
    assert html_response(conn, 200) =~ "Edit feature"
  end

  @tag :login
  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    feature = Repo.insert! %Feature{}
    conn = put conn, feature_path(conn, :update, feature), feature: @valid_attrs
    assert redirected_to(conn) == feature_path(conn, :show, feature)
    assert Repo.get_by(Feature, @valid_attrs)
  end

  @tag :login
  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    feature = Repo.insert! %Feature{}
    conn = put conn, feature_path(conn, :update, feature), feature: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit feature"
  end

  @tag :login
  test "deletes chosen resource", %{conn: conn} do
    feature = Repo.insert! %Feature{}
    conn = delete conn, feature_path(conn, :delete, feature)
    assert redirected_to(conn) == feature_path(conn, :index)
    refute Repo.get(Feature, feature.id)
  end
end
