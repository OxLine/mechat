defmodule Mechat.Dialogs.UserDialog do
  use Ecto.Schema

  schema "dialogs_user_dialog" do
    field :unreaded, :integer, default: 0

    belongs_to :user, Mechat.Dialogs.User
    belongs_to :dialog, Mechat.Dialogs.Dialog
    timestamps()
  end
end
