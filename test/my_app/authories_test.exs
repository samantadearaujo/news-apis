defmodule AppNews.AuthoriesTest do
  use AppNews.DataCase

  alias AppNews.Authories

  describe "auhtories" do
    alias AppNews.Authories.Author

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def author_fixture(attrs \\ %{}) do
      {:ok, author} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Authories.create_author()

      author
    end

    test "list_auhtories/0 returns all auhtories" do
      author = author_fixture()
      assert Authories.list_auhtories() == [author]
    end

    test "get_author!/1 returns the author with given id" do
      author = author_fixture()
      assert Authories.get_author!(author.id) == author
    end

    test "create_author/1 with valid data creates a author" do
      assert {:ok, %Author{} = author} = Authories.create_author(@valid_attrs)
      assert author.name == "some name"
    end

    test "create_author/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Authories.create_author(@invalid_attrs)
    end

    test "update_author/2 with valid data updates the author" do
      author = author_fixture()
      assert {:ok, %Author{} = author} = Authories.update_author(author, @update_attrs)
      assert author.name == "some updated name"
    end

    test "update_author/2 with invalid data returns error changeset" do
      author = author_fixture()
      assert {:error, %Ecto.Changeset{}} = Authories.update_author(author, @invalid_attrs)
      assert author == Authories.get_author!(author.id)
    end

    test "delete_author/1 deletes the author" do
      author = author_fixture()
      assert {:ok, %Author{}} = Authories.delete_author(author)
      assert_raise Ecto.NoResultsError, fn -> Authories.get_author!(author.id) end
    end

    test "change_author/1 returns a author changeset" do
      author = author_fixture()
      assert %Ecto.Changeset{} = Authories.change_author(author)
    end
  end
end
