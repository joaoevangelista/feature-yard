defmodule Featureyard.Repo.Migrations.CreateClient do
  use Ecto.Migration

  def change do
    create table(:clients) do
      add :name, :string

      timestamps()
    end

  end
end
