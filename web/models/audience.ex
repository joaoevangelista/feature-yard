defmodule Featureyard.Audience do
  use Featureyard.Web, :model

  schema "audiences" do
    field :description, :string
    field :key, :string
    belongs_to :feature, Featureyard.Feature

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:description, :key, :feature_id])
    |> validate_required([:key, :feature_id])
  end
end
