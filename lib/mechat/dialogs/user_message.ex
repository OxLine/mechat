defmodule Mechat.Dialogs.UserMessage do
  use Ecto.Schema

  schema "dialogs_user_messages" do
    field :is_readed, :boolean, default: false

    belongs_to :user, Mechat.Accounts.User
    belongs_to :message, Mechat.Dialogs.Message

    timestamps()
  end
end
