defmodule AppNews.Repo.Migrations.CreateAuhtories do
  use Ecto.Migration

  def change do
    create table(:authories, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string

      timestamps()
    end
  end
end
