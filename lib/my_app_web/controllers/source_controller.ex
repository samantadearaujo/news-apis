defmodule AppNewsWeb.SourceController do
  use AppNewsWeb, :controller

  alias AppNews.Sources
  alias AppNews.Sources.Source
  alias AppNews.Authories.Author
  alias AppNews.Categories.Category
  alias AppNews.Sources.CategoryAuthor
  import Ecto.Query

  action_fallback AppNewsWeb.FallbackController

  def index(conn, _params) do
    sources = Sources.list_sources()
    render(conn, "index.json", sources: sources)
  end

  def create(conn, %{"source" => source_params}) do
    with {:ok, %Source{} = source} <- Sources.create_source(source_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.source_path(conn, :show, source))
      |> render("show.json", source: source)
    end
  end

  def show(conn, %{"id" => id}) do
    query =
      from(
        s in "sources",
        where: s.id == ^id,
        join: cat_aut in "categories_authories",
        on: s.categories_authores == cat_aut.id,
        join: author in "authores",
        on: cat_aut.authorID == author.id,
        join: category in "categories",
        on: cat_aut.categoryID == category.id,
        select: %{
          source: %{id: s.id, name: s.name},
          title: s.title,
          category: category.name,
          author: author.name,
          description: s.description,
          url: s.url,
          urlToImage: s.urlToImage,
          publishedAt: s.inserted_At,
          content: s.content
        }
      )

    source = Repo.get_source!(query)

    render(conn, "show.json", source: source)
  end

  def update(conn, %{"id" => id, "source" => source_params}) do
    source = Sources.get_source!(id)

    with {:ok, %Source{} = source} <- Sources.update_source(source, source_params) do
      render(conn, "show.json", source: source)
    end
  end

  def delete(conn, %{"id" => id}) do
    source = Sources.get_source!(id)

    with {:ok, %Source{}} <- Sources.delete_source(source) do
      send_resp(conn, :no_content, "")
    end
  end
end
