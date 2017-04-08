defmodule Mechat.Repo.Migrations.CreateMechat.Dialogs.Dialog do
  use Ecto.Migration

  def change do
    create table(:dialogs_dialogs) do
      add :user_1_id, references(:accounts_users, on_delete: :delete_all), null: false
      add :user_2_id, references(:accounts_users, on_delete: :delete_all), null: false

      timestamps()
    end

  end
end
