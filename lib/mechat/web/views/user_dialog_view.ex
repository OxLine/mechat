defmodule Mechat.Web.UserDialogView do
  use Mechat.Web, :view
  alias Mechat.Web.UserDialogView

  def render("index.json", %{user_dialog: user_dialog}) do
    %{data: render_many(user_dialog, UserDialogView, "user_dialog.json")}
  end

  def render("show.json", %{user_dialog: user_dialog}) do
    %{data: render_one(user_dialog, UserDialogView, "user_dialog.json")}
  end

  def render("user_dialog.json", %{user_dialog: user_dialog}) do
    %{id: user_dialog.id,
      ureaded: user_dialog.ureaded}
  end
end
