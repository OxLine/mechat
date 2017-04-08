defmodule Mechat.Web.SessionView do
  use Mechat.Web, :view
  alias Mechat.Web.SessionView
  
  def render("show.json", %{user: user, jwt: jwt}) do
    %{
      data: render_one(user, Mechat.Web.UserView, "user.json"),
      meta: %{token: jwt}
    }
  end

  def render("delete.json", _) do
    %{ok: true}
  end
end
