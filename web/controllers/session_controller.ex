defmodule Featureyard.SessionController do
  use Featureyard.Web, :controller

  alias Featureyard.User

  def new(conn, _params) do
    changeset = User.login_changeset(%User{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    user = User.from_email(user_params["email"] || "") |> Repo.one

    case User.validate_password(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Signed in.")
        |> Guardian.Plug.sign_in(user, :token)
        |> redirect(to: client_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def delete(conn, _params) do
    Guardian.Plug.sign_out(conn)
    |> put_flash(:info, "Signed out successfully.")
    |> redirect(to: "/")
  end

  def unauthenticated(conn, _params) do
    conn
    |> put_flash(:error, "Authentication required")
    |> redirect(to: sign_in_path(conn, :new))
  end
end
