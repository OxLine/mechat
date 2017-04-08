defmodule Mechat.Dialogs.Dialog do
  use Ecto.Schema

  schema "dialogs_dialogs" do
    belongs_to :user_1, Mechat.Accounts.User
    belongs_to :user_2, Mechat.Accounts.User

    timestamps()
  end
end
