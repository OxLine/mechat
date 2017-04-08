defmodule Mechat.Web.UserView do
  use Mechat.Web, :view
  alias Mechat.Web.UserView

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
    }
  end
end
