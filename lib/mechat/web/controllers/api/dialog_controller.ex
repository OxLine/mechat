defmodule Mechat.Web.DialogController do
  use Mechat.Web, :controller

  alias Mechat.Accounts
  alias Mechat.Dialogs
  alias Mechat.Dialogs.Dialog

  action_fallback Mechat.Web.FallbackController

  def index(conn, _params) do
    user = Accounts.get_current_user(conn)
    dialogs = Dialogs.list_dialogs_by_user(user)
    render(conn, "index.json", dialogs: dialogs)
  end

  def create(conn, %{"dialog" => dialog_params}) do
    with dialog <- Dialogs.create_dialog(dialog_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", dialog_path(conn, :show, dialog))
      |> render("show.json", dialog: dialog)
    end
  end

  def show(conn, %{"id" => id}) do
    dialog = Dialogs.get_dialog!(id)
    render(conn, "show.json", dialog: dialog)
  end

  def update(conn, %{"id" => id, "dialog" => dialog_params}) do
    dialog = Dialogs.get_dialog!(id)

    with {:ok, %Dialog{} = dialog} <- Dialogs.update_dialog(dialog, dialog_params) do
      render(conn, "show.json", dialog: dialog)
    end
  end

  def delete(conn, %{"id" => id}) do
    dialog = Dialogs.get_dialog!(id)
    with {:ok, %Dialog{}} <- Dialogs.delete_dialog(dialog) do
      send_resp(conn, :no_content, "")
    end
  end
end
