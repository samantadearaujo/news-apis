defmodule AppNews.Repo.Migrations.CreateSources do
  use Ecto.Migration

  def change do
    create table(:sources, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :categories_authores, :binary_id
      add :title, :string
      add :description, :string
      add :url, :string
      add :urlToImage, :string
      add :publishedAt, :utc_datetime
      add :content, :string

      timestamps()
    end
  end
end
