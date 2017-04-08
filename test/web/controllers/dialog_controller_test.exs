defmodule Mechat.Web.DialogControllerTest do
  use Mechat.Web.ConnCase

  alias Mechat.Dialogs
  alias Mechat.Dialogs.Dialog

  @create_attrs %{is_muted: true}
  @update_attrs %{is_muted: false}
  @invalid_attrs %{is_muted: nil}

  def fixture(:dialog) do
    {:ok, dialog} = Dialogs.create_dialog(@create_attrs)
    dialog
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, dialog_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates dialog and renders dialog when data is valid", %{conn: conn} do
    conn = post conn, dialog_path(conn, :create), dialog: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, dialog_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "is_muted" => true}
  end

  test "does not create dialog and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, dialog_path(conn, :create), dialog: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen dialog and renders dialog when data is valid", %{conn: conn} do
    %Dialog{id: id} = dialog = fixture(:dialog)
    conn = put conn, dialog_path(conn, :update, dialog), dialog: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, dialog_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "is_muted" => false}
  end

  test "does not update chosen dialog and renders errors when data is invalid", %{conn: conn} do
    dialog = fixture(:dialog)
    conn = put conn, dialog_path(conn, :update, dialog), dialog: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen dialog", %{conn: conn} do
    dialog = fixture(:dialog)
    conn = delete conn, dialog_path(conn, :delete, dialog)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, dialog_path(conn, :show, dialog)
    end
  end
end
