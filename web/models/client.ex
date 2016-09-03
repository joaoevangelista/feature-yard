defmodule Featureyard.Client do
  use Featureyard.Web, :model

  schema "clients" do
    field :name, :string
    field :key, :string, default: UUID.uuid1()
    has_many :features, Featureyard.Feature, on_delete: :delete_all
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
