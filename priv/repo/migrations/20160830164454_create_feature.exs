defmodule Featureyard.Repo.Migrations.CreateFeature do
  use Ecto.Migration

  def change do
    create table(:features) do
      add :name, :string
      add :key, :string
      add :enabled, :boolean, default: false, null: false
      add :client_id, references(:clients, on_delete: :nothing)

      timestamps()
    end
    create index(:features, [:client_id])

  end
end
