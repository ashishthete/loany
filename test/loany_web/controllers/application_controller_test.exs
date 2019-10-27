defmodule LoanyWeb.ApplicationControllerTest do
  use LoanyWeb.ConnCase

  alias Loany.Applications

  @create_attrs %{amount: 42, email: "some email", names: [], phone: "some phone"}
  @update_attrs %{amount: 43, email: "some updated email", names: [], phone: "some updated phone"}
  @invalid_attrs %{amount: nil, email: nil, names: nil, phone: nil}

  def fixture(:application) do
    {:ok, application} = Applications.create_application(@create_attrs)
    application
  end

  describe "index" do
    test "lists all applications", %{conn: conn} do
      conn = get(conn, Routes.application_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Applications"
    end
  end

  describe "new application" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.application_path(conn, :new))
      assert html_response(conn, 200) =~ "New Application"
    end
  end

  describe "create application" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.application_path(conn, :create), application: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.application_path(conn, :show, id)

      conn = get(conn, Routes.application_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Application"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.application_path(conn, :create), application: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Application"
    end
  end

  describe "edit application" do
    setup [:create_application]

    test "renders form for editing chosen application", %{conn: conn, application: application} do
      conn = get(conn, Routes.application_path(conn, :edit, application))
      assert html_response(conn, 200) =~ "Edit Application"
    end
  end

  describe "update application" do
    setup [:create_application]

    test "redirects when data is valid", %{conn: conn, application: application} do
      conn = put(conn, Routes.application_path(conn, :update, application), application: @update_attrs)
      assert redirected_to(conn) == Routes.application_path(conn, :show, application)

      conn = get(conn, Routes.application_path(conn, :show, application))
      assert html_response(conn, 200) =~ "some updated email"
    end

    test "renders errors when data is invalid", %{conn: conn, application: application} do
      conn = put(conn, Routes.application_path(conn, :update, application), application: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Application"
    end
  end

  describe "delete application" do
    setup [:create_application]

    test "deletes chosen application", %{conn: conn, application: application} do
      conn = delete(conn, Routes.application_path(conn, :delete, application))
      assert redirected_to(conn) == Routes.application_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.application_path(conn, :show, application))
      end
    end
  end

  defp create_application(_) do
    application = fixture(:application)
    {:ok, application: application}
  end
end
