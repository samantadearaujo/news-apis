defmodule AppNewsWeb.AuthorView do
  use AppNewsWeb, :view
  alias AppNewsWeb.AuthorView

  def render("index.json", %{auhtories: auhtories}) do
    %{data: render_many(auhtories, AuthorView, "author.json")}
  end

  def render("show.json", %{author: author}) do
    %{data: render_one(author, AuthorView, "author.json")}
  end

  def render("author.json", %{author: author}) do
    %{id: author.id, name: author.name}
  end
end
