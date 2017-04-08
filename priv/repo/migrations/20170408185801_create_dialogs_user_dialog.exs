defmodule Mechat.Repo.Migrations.CreateMechat.Dialogs.UserDialog do
  use Ecto.Migration

  def change do
    create table(:dialogs_user_dialog) do
      add :unreaded, :integer, default: 0

      add :user_id, references(:accounts_users, on_delete: :delete_all), null: false
      add :dialog_id, references(:dialogs_dialogs, on_delete: :delete_all), null: false
      timestamps()
    end

  end
end
