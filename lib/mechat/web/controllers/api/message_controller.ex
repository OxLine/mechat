defmodule Mechat.Web.MessageController do
  use Mechat.Web, :controller

  alias Mechat.Dialogs
  alias Mechat.Dialogs.Message

  action_fallback Mechat.Web.FallbackController

  def index(conn, _params) do
    messages = Dialogs.list_messages()
    render(conn, "index.json", messages: messages)
  end

  def create(conn, %{"message" => message_params}) do
    # TODO: get or create dialog
    with {:ok, %Message{} = message} <- Dialogs.create_message(message_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", message_path(conn, :show, message))
      |> render("show.json", message: message)
    end
  end

  def show(conn, %{"id" => id}) do
    message = Dialogs.get_message!(id)
    render(conn, "show.json", message: message)
  end

  def update(conn, %{"id" => id, "message" => message_params}) do
    message = Dialogs.get_message!(id)

    with {:ok, %Message{} = message} <- Dialogs.update_message(message, message_params) do
      render(conn, "show.json", message: message)
    end
  end

  def delete(conn, %{"id" => id}) do
    message = Dialogs.get_message!(id)
    with {:ok, %Message{}} <- Dialogs.delete_message(message) do
      send_resp(conn, :no_content, "")
    end
  end
end
