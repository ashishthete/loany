defmodule Loany.ApplicationsTest do
  use Loany.DataCase

  alias Loany.Applications

  describe "applications" do
    alias Loany.Applications.Application

    @valid_attrs %{amount: 42, email: "some email", names: [], phone: "some phone"}
    @update_attrs %{amount: 43, email: "some updated email", names: [], phone: "some updated phone"}
    @invalid_attrs %{amount: nil, email: nil, names: nil, phone: nil}

    def application_fixture(attrs \\ %{}) do
      {:ok, application} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Applications.create_application()

      application
    end

    test "list_applications/0 returns all applications" do
      application = application_fixture()
      assert Applications.list_applications() == [application]
    end

    test "get_application!/1 returns the application with given id" do
      application = application_fixture()
      assert Applications.get_application!(application.id) == application
    end

    test "create_application/1 with valid data creates a application" do
      assert {:ok, %Application{} = application} = Applications.create_application(@valid_attrs)
      assert application.amount == 42
      assert application.email == "some email"
      assert application.names == []
      assert application.phone == "some phone"
    end

    test "create_application/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Applications.create_application(@invalid_attrs)
    end

    test "update_application/2 with valid data updates the application" do
      application = application_fixture()
      assert {:ok, %Application{} = application} = Applications.update_application(application, @update_attrs)
      assert application.amount == 43
      assert application.email == "some updated email"
      assert application.names == []
      assert application.phone == "some updated phone"
    end

    test "update_application/2 with invalid data returns error changeset" do
      application = application_fixture()
      assert {:error, %Ecto.Changeset{}} = Applications.update_application(application, @invalid_attrs)
      assert application == Applications.get_application!(application.id)
    end

    test "delete_application/1 deletes the application" do
      application = application_fixture()
      assert {:ok, %Application{}} = Applications.delete_application(application)
      assert_raise Ecto.NoResultsError, fn -> Applications.get_application!(application.id) end
    end

    test "change_application/1 returns a application changeset" do
      application = application_fixture()
      assert %Ecto.Changeset{} = Applications.change_application(application)
    end
  end
end
