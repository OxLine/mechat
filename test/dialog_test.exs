defmodule Mechat.DialogTest do
  use Mechat.DataCase

  alias Mechat.Dialog
  alias Mechat.Dialog.Message

  @create_attrs %{body: "some body"}
  @update_attrs %{body: "some updated body"}
  @invalid_attrs %{body: nil}

  def fixture(:message, attrs \\ @create_attrs) do
    {:ok, message} = Dialog.create_message(attrs)
    message
  end

  test "list_messsages/1 returns all messsages" do
    message = fixture(:message)
    assert Dialog.list_messsages() == [message]
  end

  test "get_message! returns the message with given id" do
    message = fixture(:message)
    assert Dialog.get_message!(message.id) == message
  end

  test "create_message/1 with valid data creates a message" do
    assert {:ok, %Message{} = message} = Dialog.create_message(@create_attrs)
    assert message.body == "some body"
  end

  test "create_message/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Dialog.create_message(@invalid_attrs)
  end

  test "update_message/2 with valid data updates the message" do
    message = fixture(:message)
    assert {:ok, message} = Dialog.update_message(message, @update_attrs)
    assert %Message{} = message
    assert message.body == "some updated body"
  end

  test "update_message/2 with invalid data returns error changeset" do
    message = fixture(:message)
    assert {:error, %Ecto.Changeset{}} = Dialog.update_message(message, @invalid_attrs)
    assert message == Dialog.get_message!(message.id)
  end

  test "delete_message/1 deletes the message" do
    message = fixture(:message)
    assert {:ok, %Message{}} = Dialog.delete_message(message)
    assert_raise Ecto.NoResultsError, fn -> Dialog.get_message!(message.id) end
  end

  test "change_message/1 returns a message changeset" do
    message = fixture(:message)
    assert %Ecto.Changeset{} = Dialog.change_message(message)
  end
end
