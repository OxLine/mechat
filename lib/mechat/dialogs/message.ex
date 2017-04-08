defmodule Mechat.Dialogs.Message do
  use Ecto.Schema

  schema "dialogs_messages" do
    field :body, :string

    belongs_to :user, Mechat.Accounts.User
    belongs_to :dialog, Mechat.Dialogs.Dialog
    timestamps()
  end
end
