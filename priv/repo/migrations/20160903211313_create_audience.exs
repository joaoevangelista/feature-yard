defmodule Featureyard.Repo.Migrations.CreateAudience do
  use Ecto.Migration

  def change do
    create table(:audiences) do
      add :description, :string
      add :key, :string
      add :feature_id, references(:features, on_delete: :nothing)

      timestamps()
    end
    create index(:audiences, [:feature_id])

  end
end
