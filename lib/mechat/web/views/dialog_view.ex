defmodule Mechat.Web.DialogView do
  use Mechat.Web, :view
  alias Mechat.Web.DialogView

  def render("index.json", %{dialogs: dialogs}) do
    %{data: render_many(dialogs, DialogView, "dialog.json")}
  end

  def render("show.json", %{dialog: dialog}) do
    %{data: render_one(dialog, DialogView, "dialog.json")}
  end

  def render("dialog.json", %{dialog: dialog}) do
    %{id: dialog.id,
      last_message: %{
        id: dialog.last_message.id,
        inserted_at: dialog.last_message.inserted_at,
        user_id: dialog.last_message.user_id,
        body: dialog.last_message.body,
        is_readed: dialog.last_message.is_readed,
      },
      unreaded: dialog.unreaded,
      username: dialog.username,
    }
  end
end
