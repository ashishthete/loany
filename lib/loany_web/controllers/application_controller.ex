defmodule LoanyWeb.ApplicationController do
  use LoanyWeb, :controller

  alias Loany.Controller.Applications 
  alias Loany.Model.Application

  def index(conn, _params) do
    applications = Applications.list_applications()
    render(conn, "index.html", applications: applications)
  end

  def new(conn, _params) do
    changeset = Applications.change_application(%Application{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"application" => application_params}) do
    case Applications.create_application(application_params) do
      {:ok, application} ->
        conn
        |> put_flash(:info, "Application created successfully.")
        |> redirect(to: Routes.application_path(conn, :show, application))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    application = Applications.get_application!(id)
    case application do
      %Application{status: "accepted"} ->
        render(conn, "show.html", application: application)
      %Application{status: "rejected"} ->
        render(conn, "reject.html", application: application)
    end
  end

  def edit(conn, %{"id" => id}) do
    application = Applications.get_application!(id)
    changeset = Applications.change_application(application)
    render(conn, "edit.html", application: application, changeset: changeset)
  end

  def update(conn, %{"id" => id, "application" => application_params}) do
    application = Applications.get_application!(id)

    case Applications.update_application(application, application_params) do
      {:ok, application} ->
        conn
        |> put_flash(:info, "Application updated successfully.")
        |> redirect(to: Routes.application_path(conn, :show, application))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", application: application, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    application = Applications.get_application!(id)
    {:ok, _application} = Applications.delete_application(application)

    conn
    |> put_flash(:info, "Application deleted successfully.")
    |> redirect(to: Routes.application_path(conn, :index))
  end
end
