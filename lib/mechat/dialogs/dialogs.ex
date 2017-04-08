defmodule Mechat.Dialogs do
  @moduledoc """
  The boundary for the Dialogs system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias Mechat.Repo

  alias Mechat.Dialogs.Dialog

  @doc """
  Returns the list of dialogs.

  ## Examples

      iex> list_dialogs()
      [%Dialog{}, ...]

  """
  def list_dialogs do
    Repo.all(Dialog)
  end

  def list_dialogs_by_user(user) do
    # TODO: lats messages or created + sort by
    # TODO: number of unreaded messages
    Repo.all(from t in Dialog, where: t.user_1_id == ^user.id or t.user_2_id == ^user.id)
    |> Enum.map(& Map.put(&1, :unreaded, get_count_unreaded(user.id, &1.id)))
    |> Enum.map(& Map.put(&1, :username, user.username))
    |> Enum.map(& Map.put(&1, :last_message, get_last_message(user.id, &1.id)))
  end

  @doc """
  Gets a single dialog.

  Raises `Ecto.NoResultsError` if the Dialog does not exist.

  ## Examples

      iex> get_dialog!(123)
      %Dialog{}

      iex> get_dialog!(456)
      ** (Ecto.NoResultsError)

  """
  def get_dialog!(id), do: Repo.get!(Dialog, id)

  def get_dialog_by_users(user_1_id, user_2_id) do
    Repo.get_by(Dialog, [user_1_id: user_1_id, user_2_id: user_2_id])
  end

  @doc """
  Creates a dialog.

  ## Examples

      iex> create_dialog(%{field: value})
      {:ok, %Dialog{}}

      iex> create_dialog(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_dialog(attrs \\ %{}) do
    if get_dialog_by_users(attrs.user_1_id, attrs.user_2_id) || get_dialog_by_users(attrs.user_2_id, attrs.user_1_id) do
      {:error, :already_exist} 
    else
      {:ok, %Dialog{} = dialog} = 
        %Dialog{}
        |> dialog_changeset(attrs)
        |> Repo.insert()

      create_user_dialog(%{user_id: dialog.user_1_id, dialog_id: dialog.id})
      if dialog.user_1_id != dialog.user_2_id do
        create_user_dialog(%{user_id: dialog.user_2_id, dialog_id: dialog.id})
      end

      dialog
    end
  end

  @doc """
  Updates a dialog.

  ## Examples

      iex> update_dialog(dialog, %{field: new_value})
      {:ok, %Dialog{}}

      iex> update_dialog(dialog, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_dialog(%Dialog{} = dialog, attrs) do
    dialog
    |> dialog_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Dialog.

  ## Examples

      iex> delete_dialog(dialog)
      {:ok, %Dialog{}}

      iex> delete_dialog(dialog)
      {:error, %Ecto.Changeset{}}

  """
  def delete_dialog(%Dialog{} = dialog) do
    Repo.delete(dialog)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking dialog changes.

  ## Examples

      iex> change_dialog(dialog)
      %Ecto.Changeset{source: %Dialog{}}

  """
  def change_dialog(%Dialog{} = dialog) do
    dialog_changeset(dialog, %{})
  end

  defp dialog_changeset(%Dialog{} = dialog, attrs) do
    dialog
    |> cast(attrs, [:user_1_id, :user_2_id])
    |> validate_required([:user_1_id, :user_2_id])
    # |> assoc_constraint(:user_2_id)
  end

  alias Mechat.Dialogs.Message

  @doc """
  Returns the list of messages.

  ## Examples

      iex> list_messages()
      [%Message{}, ...]

  """
  def list_messages do
    Repo.all(Message)
  end

  @doc """
  Gets a single message.

  Raises `Ecto.NoResultsError` if the Message does not exist.

  ## Examples

      iex> get_message!(123)
      %Message{}

      iex> get_message!(456)
      ** (Ecto.NoResultsError)

  """
  def get_message!(id), do: Repo.get!(Message, id)

  @doc """
  Creates a message.

  ## Examples

      iex> create_message(%{field: value})
      {:ok, %Message{}}

      iex> create_message(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  # TODO: get dialog users
  def create_message(attrs \\ %{}) do
    %Message{}
    |> message_changeset(attrs)
    |> Repo.insert()
  end
  
  @doc """
  Updates a message.

  ## Examples

      iex> update_message(message, %{field: new_value})
      {:ok, %Message{}}

      iex> update_message(message, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_message(%Message{} = message, attrs) do
    message
    |> message_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Message.

  ## Examples

      iex> delete_message(message)
      {:ok, %Message{}}

      iex> delete_message(message)
      {:error, %Ecto.Changeset{}}

  """
  def delete_message(%Message{} = message) do
    Repo.delete(message)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking message changes.

  ## Examples

      iex> change_message(message)
      %Ecto.Changeset{source: %Message{}}

  """
  def change_message(%Message{} = message) do
    message_changeset(message, %{})
  end

  defp message_changeset(%Message{} = message, attrs) do
    message
    |> cast(attrs, [:body, :user_id, :dialog_id])
    |> validate_required([:body, :user_id, :dialog_id])
  end

  alias Mechat.Dialogs.UserMessage

  @doc """
  Returns the list of user_messages.

  ## Examples

      iex> list_user_messages()
      [%UserMessage{}, ...]

  """
  def list_user_messages do
    Repo.all(UserMessage)
  end

  @doc """
  Gets a single user_message.

  Raises `Ecto.NoResultsError` if the User message does not exist.

  ## Examples

      iex> get_user_message!(123)
      %UserMessage{}

      iex> get_user_message!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_message!(id), do: Repo.get!(UserMessage, id)

  @doc """
  Creates a user_message.

  ## Examples

      iex> create_user_message(%{field: value})
      {:ok, %UserMessage{}}

      iex> create_user_message(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  # TODO: if attrs.user not in dialog
  def create_user_messages(attrs \\ %{}) do
    {:ok, %Message{} = message} = create_message(attrs)
    dialog = get_dialog!(attrs.dialog_id)
    user_1_id = dialog.user_1_id
    user_2_id = dialog.user_2_id


    user_message_1 = 
      %UserMessage{}
      |> user_message_changeset(%{user_id: user_1_id, message_id: message.id})
      |> Repo.insert()

    user_message_2 =
      %UserMessage{}
      |> user_message_changeset(%{user_id: user_2_id, message_id: message.id})
      |> Repo.insert()

    case attrs.user_id do
      ^user_1_id ->
        inc_unreaded(user_2_id, dialog.id)
        user_message_1
      ^user_2_id ->
        inc_unreaded(user_1_id, dialog.id)
        user_message_2
      _ ->
        {:error, :permission_denied}
    end
  end


  @doc """
  Updates a user_message.

  ## Examples

      iex> update_user_message(user_message, %{field: new_value})
      {:ok, %UserMessage{}}

      iex> update_user_message(user_message, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_message(%UserMessage{} = user_message, attrs) do
    user_message
    |> user_message_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a UserMessage.

  ## Examples

      iex> delete_user_message(user_message)
      {:ok, %UserMessage{}}

      iex> delete_user_message(user_message)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_message(%UserMessage{} = user_message) do
    Repo.delete(user_message)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_message changes.

  ## Examples

      iex> change_user_message(user_message)
      %Ecto.Changeset{source: %UserMessage{}}

  """
  def change_user_message(%UserMessage{} = user_message) do
    user_message_changeset(user_message, %{})
  end

  defp user_message_changeset(%UserMessage{} = user_message, attrs) do
    user_message
    |> cast(attrs, [:is_readed, :user_id, :message_id])
    |> validate_required([:is_readed, :user_id, :message_id])
  end

  # readed/unreaded
  defp get_last_message(user_id, dialog_id) do
    message = Repo.one(from t in Message, where: t.dialog_id == ^dialog_id, order_by: [desc: t.inserted_at], limit: 1)
    user_message = Repo.get_by(UserMessage, [user_id: user_id, message_id: message.id]) 

    message
    |> Map.put(:is_readed, user_message.is_readed)
  end

  alias Mechat.Dialogs.UserDialog

  @doc """
  Returns the list of user_dialog.

  ## Examples

      iex> list_user_dialog()
      [%UserDialog{}, ...]

  """
  def list_user_dialog do
    Repo.all(UserDialog)
  end

  @doc """
  Gets a single user_dialog.

  Raises `Ecto.NoResultsError` if the User dialog does not exist.

  ## Examples

      iex> get_user_dialog!(123)
      %UserDialog{}

      iex> get_user_dialog!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_dialog!(id), do: Repo.get!(UserDialog, id)

  @doc """
  Creates a user_dialog.

  ## Examples

      iex> create_user_dialog(%{field: value})
      {:ok, %UserDialog{}}

      iex> create_user_dialog(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_dialog(attrs \\ %{}) do
    %UserDialog{}
    |> user_dialog_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_dialog.

  ## Examples

      iex> update_user_dialog(user_dialog, %{field: new_value})
      {:ok, %UserDialog{}}

      iex> update_user_dialog(user_dialog, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_dialog(%UserDialog{} = user_dialog, attrs) do
    user_dialog
    |> user_dialog_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a UserDialog.

  ## Examples

      iex> delete_user_dialog(user_dialog)
      {:ok, %UserDialog{}}

      iex> delete_user_dialog(user_dialog)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_dialog(%UserDialog{} = user_dialog) do
    Repo.delete(user_dialog)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_dialog changes.

  ## Examples

      iex> change_user_dialog(user_dialog)
      %Ecto.Changeset{source: %UserDialog{}}

  """
  def change_user_dialog(%UserDialog{} = user_dialog) do
    user_dialog_changeset(user_dialog, %{})
  end

  defp inc_unreaded(user_id, dialog_id) do
    user_dialog = Repo.get_by(Mechat.Dialogs.UserDialog, [user_id: user_id, dialog_id: dialog_id])

    user_dialog
    |> user_dialog_changeset(%{unreaded: user_dialog.unreaded + 1})
    |> Repo.update()
  end

  defp get_count_unreaded(user_id, dialog_id) do
    Repo.get_by(Mechat.Dialogs.UserDialog, [user_id: user_id, dialog_id: dialog_id]).unreaded
  end

  defp user_dialog_changeset(%UserDialog{} = user_dialog, attrs) do
    user_dialog
    |> cast(attrs, [:unreaded, :user_id, :dialog_id])
    |> validate_required([:unreaded, :user_id, :dialog_id])
  end
end
