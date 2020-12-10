defmodule AppNewsWeb.AuthorController do
  use AppNewsWeb, :controller

  alias AppNews.Authories
  alias AppNews.Authories.Author

  action_fallback AppNewsWeb.FallbackController

  def index(conn, _params) do
    auhtories = Authories.list_auhtories()
    render(conn, "index.json", auhtories: auhtories)
  end

  def create(conn, %{"author" => author_params}) do
    with {:ok, %Author{} = author} <- Authories.create_author(author_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.author_path(conn, :show, author))
      |> render("show.json", author: author)
    end
  end

  def show(conn, %{"id" => id}) do
    author = Authories.get_author!(id)
    render(conn, "show.json", author: author)
  end

  def update(conn, %{"id" => id, "author" => author_params}) do
    author = Authories.get_author!(id)

    with {:ok, %Author{} = author} <- Authories.update_author(author, author_params) do
      render(conn, "show.json", author: author)
    end
  end

  def delete(conn, %{"id" => id}) do
    author = Authories.get_author!(id)

    with {:ok, %Author{}} <- Authories.delete_author(author) do
      send_resp(conn, :no_content, "")
    end
  end
end
