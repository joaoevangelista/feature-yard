defmodule Featureyard.FeatureTest do
  use Featureyard.ModelCase

  alias Featureyard.Feature

  @valid_attrs %{enabled: true, key: "FEATURE_FOO", name: "Foo feature"}
  @invalid_attrs %{enabled: true, name: "Foo feature"}

  test "changeset with valid attributes" do
    changeset = Feature.changeset(%Feature{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Feature.changeset(%Feature{}, @invalid_attrs)
    refute changeset.valid?
  end
end
