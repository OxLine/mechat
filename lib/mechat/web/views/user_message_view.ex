defmodule Mechat.Web.UserMessageView do
  use Mechat.Web, :view
  alias Mechat.Web.UserMessageView

  def render("index.json", %{user_messages: user_messages}) do
    %{data: render_many(user_messages, UserMessageView, "user_message.json")}
  end

  def render("show.json", %{user_message: user_message}) do
    %{data: render_one(user_message, UserMessageView, "user_message.json")}
  end

  def render("user_message.json", %{user_message: user_message}) do
    %{id: user_message.id,
      is_readed: user_message.is_readed}
  end
end
