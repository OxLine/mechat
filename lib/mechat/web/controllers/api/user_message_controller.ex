# defmodule Mechat.Web.UserMessageController do
#   use Mechat.Web, :controller
# 
#   alias Mechat.Dialogs
#   alias Mechat.Dialogs.UserMessage
# 
#   action_fallback Mechat.Web.FallbackController
# 
#   def index(conn, _params) do
#     user_messages = Dialogs.list_user_messages()
#     render(conn, "index.json", user_messages: user_messages)
#   end
# 
#   def create(conn, %{"user_message" => user_message_params}) do
#     with {:ok, %UserMessage{} = user_message} <- Dialogs.create_user_message(user_message_params) do
#       conn
#       |> put_status(:created)
#       |> put_resp_header("location", user_message_path(conn, :show, user_message))
#       |> render("show.json", user_message: user_message)
#     end
#   end
# 
#   def show(conn, %{"id" => id}) do
#     user_message = Dialogs.get_user_message!(id)
#     render(conn, "show.json", user_message: user_message)
#   end
# 
#   def update(conn, %{"id" => id, "user_message" => user_message_params}) do
#     user_message = Dialogs.get_user_message!(id)
# 
#     with {:ok, %UserMessage{} = user_message} <- Dialogs.update_user_message(user_message, user_message_params) do
#       render(conn, "show.json", user_message: user_message)
#     end
#   end
# 
#   def delete(conn, %{"id" => id}) do
#     user_message = Dialogs.get_user_message!(id)
#     with {:ok, %UserMessage{}} <- Dialogs.delete_user_message(user_message) do
#       send_resp(conn, :no_content, "")
#     end
#   end
# end
