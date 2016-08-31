defmodule Featureyard.Repo.Migrations.AddKeyToClient do
  use Ecto.Migration

  def change do
    alter table(:clients) do
      add :key, :string
    end
  end
end
