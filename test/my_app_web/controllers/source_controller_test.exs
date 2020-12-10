defmodule AppNewsWeb.SourceControllerTest do
  use AppNewsWeb.ConnCase

  alias AppNews.Sources
  alias AppNews.Sources.Source

  @create_attrs %{
    name: "News 2000",
    description: "description 303030",
    title: "title 77777"
  }
  @update_attrs %{
    name: "News 3000",
    description: "description 79293849",
    title: "telegram999999"
  }
  @invalid_attrs %{name: nil}

  def fixture(:source) do
    {:ok, source} = Sources.create_source(@create_attrs)
    source
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all sources", %{conn: conn} do
      conn = get(conn, Routes.source_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create source" do
    test "renders source when data is valid", %{conn: conn} do
      conn = post(conn, Routes.source_path(conn, :create), source: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.source_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.source_path(conn, :create), source: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update source" do
    setup [:create_source]

    test "renders source when data is valid", %{conn: conn, source: %Source{id: id} = source} do
      conn = put(conn, Routes.source_path(conn, :update, source), source: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.source_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, source: source} do
      conn = put(conn, Routes.source_path(conn, :update, source), source: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete source" do
    setup [:create_source]

    test "deletes chosen source", %{conn: conn, source: source} do
      conn = delete(conn, Routes.source_path(conn, :delete, source))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.source_path(conn, :show, source))
      end
    end
  end

  defp create_source(_) do
    source = fixture(:source)
    %{source: source}
  end
end
