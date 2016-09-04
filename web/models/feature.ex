defmodule Featureyard.Feature do
  use Featureyard.Web, :model

  schema "features" do
    field :name, :string
    field :key, :string
    field :enabled, :boolean, default: false
    belongs_to :client, Featureyard.Client
    has_many :audiences, Featureyard.Audience, on_delete: :delete_all
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :key, :enabled, :client_id])
    |> validate_required([:name, :key, :enabled])
  end
end
