defmodule AppNews.Repo.Migrations.CreateCategoriesAuthories do
  use Ecto.Migration

  def change do
    create table("categories_authories", primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :authorID, :integer
      add :categoryID, :integer

      timestamps()
    end
  end
end
