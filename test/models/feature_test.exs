defmodule Featureyard.FeatureTest do
  use Featureyard.ModelCase

  alias Featureyard.Feature

  @valid_attrs %{enabled: true, key: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Feature.changeset(%Feature{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Feature.changeset(%Feature{}, @invalid_attrs)
    refute changeset.valid?
  end
end
