defmodule Featureyard.AudienceTest do
  use Featureyard.ModelCase

  alias Featureyard.Audience

  @valid_attrs %{description: "some content", key: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Audience.changeset(%Audience{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Audience.changeset(%Audience{}, @invalid_attrs)
    refute changeset.valid?
  end
end
