defmodule Featureyard.ClientTest do
  use Featureyard.ModelCase

  alias Featureyard.Client

  @valid_attrs %{name: "A valid name"}
  @invalid_attrs %{name: ""}

  test "changeset with valid attributes" do
    changeset = Client.changeset(%Client{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Client.changeset(%Client{}, @invalid_attrs)
    refute changeset.valid?
  end
end
