defmodule GradeKings.SessionController do
  use GradeKings.Web, :controller
  alias GradeKings.Session

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => session_params}) do
    case Session.login(session_params, GradeKings.Repo) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user.id)
        |> put_flash(:info, "Logged In Successfully")
        |> redirect(to: "/")
      :error ->
        conn
        |> put_flash(:info, "Wrong email or password")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> delete_session(:current_user)
    |> put_flash(:info, "Successfully Logged Out")
    |> redirect(to: "/")
  end
end