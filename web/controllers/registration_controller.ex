defmodule GradeKings.RegistrationController do
  use GradeKings.Web, :controller

  alias GradeKings.User

  def new(conn, _) do
    changeset = User.registration_changeset(%User{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.registration_changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user.id)
        |> put_flash(:info, "Successfully created a User")
        |> redirect(to: "/")
      {:error, changeset} -> 
        conn
        |> put_flash(:error, "There are some errors encountered")
        |> render("new.html", changeset: changeset)
    end
  end
end