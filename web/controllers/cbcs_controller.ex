defmodule GradeKings.CbcsController do
  use GradeKings.Web, :controller

  def index(conn, _) do
    render conn, "index.html"
  end
end
