defmodule Mechat.Repo.Migrations.CreateMechat.Dialogs.Message do
  use Ecto.Migration

  def change do
    create table(:dialogs_messages) do
      add :body, :text

      add :user_id, references(:accounts_users, on_delete: :delete_all), null: false
      add :dialog_id, references(:dialogs_dialogs, on_delete: :delete_all), null: false

      timestamps()
    end

  end
end
