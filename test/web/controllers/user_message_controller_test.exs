defmodule Mechat.Web.UserMessageControllerTest do
  use Mechat.Web.ConnCase

  alias Mechat.Dialogs
  alias Mechat.Dialogs.UserMessage

  @create_attrs %{is_readed: true}
  @update_attrs %{is_readed: false}
  @invalid_attrs %{is_readed: nil}

  def fixture(:user_message) do
    {:ok, user_message} = Dialogs.create_user_message(@create_attrs)
    user_message
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, user_message_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates user_message and renders user_message when data is valid", %{conn: conn} do
    conn = post conn, user_message_path(conn, :create), user_message: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, user_message_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "is_readed" => true}
  end

  test "does not create user_message and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_message_path(conn, :create), user_message: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen user_message and renders user_message when data is valid", %{conn: conn} do
    %UserMessage{id: id} = user_message = fixture(:user_message)
    conn = put conn, user_message_path(conn, :update, user_message), user_message: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, user_message_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "is_readed" => false}
  end

  test "does not update chosen user_message and renders errors when data is invalid", %{conn: conn} do
    user_message = fixture(:user_message)
    conn = put conn, user_message_path(conn, :update, user_message), user_message: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen user_message", %{conn: conn} do
    user_message = fixture(:user_message)
    conn = delete conn, user_message_path(conn, :delete, user_message)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, user_message_path(conn, :show, user_message)
    end
  end
end
