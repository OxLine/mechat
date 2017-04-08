#  defmodule Mechat.Web.UserDialogController do
#    use Mechat.Web, :controller
#  
#    alias Mechat.Dialogs
#    alias Mechat.Dialogs.UserDialog
#  
#    action_fallback Mechat.Web.FallbackController
#  
#    def index(conn, _params) do
#      user_dialog = Dialogs.list_user_dialog()
#      render(conn, "index.json", user_dialog: user_dialog)
#    end
#  
#    def create(conn, %{"user_dialog" => user_dialog_params}) do
#      with {:ok, %UserDialog{} = user_dialog} <- Dialogs.create_user_dialog(user_dialog_params) do
#        conn
#        |> put_status(:created)
#        |> put_resp_header("location", user_dialog_path(conn, :show, user_dialog))
#        |> render("show.json", user_dialog: user_dialog)
#      end
#    end
#  
#    def show(conn, %{"id" => id}) do
#      user_dialog = Dialogs.get_user_dialog!(id)
#      render(conn, "show.json", user_dialog: user_dialog)
#    end
#  
#    def update(conn, %{"id" => id, "user_dialog" => user_dialog_params}) do
#      user_dialog = Dialogs.get_user_dialog!(id)
#  
#      with {:ok, %UserDialog{} = user_dialog} <- Dialogs.update_user_dialog(user_dialog, user_dialog_params) do
#        render(conn, "show.json", user_dialog: user_dialog)
#      end
#    end
#  
#    def delete(conn, %{"id" => id}) do
#      user_dialog = Dialogs.get_user_dialog!(id)
#      with {:ok, %UserDialog{}} <- Dialogs.delete_user_dialog(user_dialog) do
#        send_resp(conn, :no_content, "")
#      end
#    end
#  end
