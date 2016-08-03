defmodule GradeKings.PageController do
  use GradeKings.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
