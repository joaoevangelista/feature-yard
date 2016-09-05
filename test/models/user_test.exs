defmodule Featureyard.UserTest do
  use Featureyard.ModelCase

  alias Featureyard.User

  @valid_attrs %{email: "evangelistajoaop@gmail.com", password: "123456789"}
  @invalid_attrs %{email: "", password: "1234566789"}

  test "changeset with valid attributes" do
    changeset = User.save_changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.save_changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
