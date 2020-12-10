defmodule AppNews.Sources.Source do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "sources" do
    field :name, :string
    field :categories_authores, :integer
    field :title, :string
    field :description, :string
    field :url, :string
    field :urlToImage, :string
    field :publishedAt, :utc_datetime
    field :content, :string

    timestamps()
  end

  @doc false
  def changeset(source, attrs) do
    source
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
