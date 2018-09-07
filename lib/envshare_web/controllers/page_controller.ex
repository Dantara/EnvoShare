defmodule EnvshareWeb.PageController do
  use EnvshareWeb, :controller

  def index(conn, _params) do
    projects = ProjectWrapper.get_projects
    render conn, "index.html", projects: projects
  end
end
