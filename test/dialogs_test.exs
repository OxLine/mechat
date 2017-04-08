defmodule Mechat.DialogsTest do
  use Mechat.DataCase

  alias Mechat.Dialogs
  alias Mechat.Dialogs.Dialog

  @create_attrs %{is_muted: true}
  @update_attrs %{is_muted: false}
  @invalid_attrs %{is_muted: nil}

  def fixture(:dialog, attrs \\ @create_attrs) do
    {:ok, dialog} = Dialogs.create_dialog(attrs)
    dialog
  end

  test "list_dialogs/1 returns all dialogs" do
    dialog = fixture(:dialog)
    assert Dialogs.list_dialogs() == [dialog]
  end

  test "get_dialog! returns the dialog with given id" do
    dialog = fixture(:dialog)
    assert Dialogs.get_dialog!(dialog.id) == dialog
  end

  test "create_dialog/1 with valid data creates a dialog" do
    assert {:ok, %Dialog{} = dialog} = Dialogs.create_dialog(@create_attrs)
    assert dialog.is_muted == true
  end

  test "create_dialog/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Dialogs.create_dialog(@invalid_attrs)
  end

  test "update_dialog/2 with valid data updates the dialog" do
    dialog = fixture(:dialog)
    assert {:ok, dialog} = Dialogs.update_dialog(dialog, @update_attrs)
    assert %Dialog{} = dialog
    assert dialog.is_muted == false
  end

  test "update_dialog/2 with invalid data returns error changeset" do
    dialog = fixture(:dialog)
    assert {:error, %Ecto.Changeset{}} = Dialogs.update_dialog(dialog, @invalid_attrs)
    assert dialog == Dialogs.get_dialog!(dialog.id)
  end

  test "delete_dialog/1 deletes the dialog" do
    dialog = fixture(:dialog)
    assert {:ok, %Dialog{}} = Dialogs.delete_dialog(dialog)
    assert_raise Ecto.NoResultsError, fn -> Dialogs.get_dialog!(dialog.id) end
  end

  test "change_dialog/1 returns a dialog changeset" do
    dialog = fixture(:dialog)
    assert %Ecto.Changeset{} = Dialogs.change_dialog(dialog)
  end
end
