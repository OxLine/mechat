defmodule Mechat.Web.UserDialogControllerTest do
  use Mechat.Web.ConnCase

  alias Mechat.Dialogs
  alias Mechat.Dialogs.UserDialog

  @create_attrs %{ureaded: 42}
  @update_attrs %{ureaded: 43}
  @invalid_attrs %{ureaded: nil}

  def fixture(:user_dialog) do
    {:ok, user_dialog} = Dialogs.create_user_dialog(@create_attrs)
    user_dialog
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, user_dialog_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates user_dialog and renders user_dialog when data is valid", %{conn: conn} do
    conn = post conn, user_dialog_path(conn, :create), user_dialog: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, user_dialog_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "ureaded" => 42}
  end

  test "does not create user_dialog and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_dialog_path(conn, :create), user_dialog: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen user_dialog and renders user_dialog when data is valid", %{conn: conn} do
    %UserDialog{id: id} = user_dialog = fixture(:user_dialog)
    conn = put conn, user_dialog_path(conn, :update, user_dialog), user_dialog: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, user_dialog_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "ureaded" => 43}
  end

  test "does not update chosen user_dialog and renders errors when data is invalid", %{conn: conn} do
    user_dialog = fixture(:user_dialog)
    conn = put conn, user_dialog_path(conn, :update, user_dialog), user_dialog: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen user_dialog", %{conn: conn} do
    user_dialog = fixture(:user_dialog)
    conn = delete conn, user_dialog_path(conn, :delete, user_dialog)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, user_dialog_path(conn, :show, user_dialog)
    end
  end
end
