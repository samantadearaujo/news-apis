defmodule AppNews.Sources.CategoryAuthor do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "categories_authories" do
    field :authorID, :integer
    field :categoryID, :integer

    timestamps()
  end

  @doc false
  def changeset(categories_authories, attrs) do
    categories_authories
    |> cast(attrs, [:id, :authorID, :categoryID])
    |> validate_required([:id])
  end
end
