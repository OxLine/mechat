defmodule Mechat.Repo.Migrations.CreateMechat.Dialogs.UserMessage do
  use Ecto.Migration

  def change do
    create table(:dialogs_user_messages) do
      add :is_readed, :boolean, default: false, null: false

      add :user_id, references(:accounts_users, on_delete: :delete_all), null: false
      add :message_id, references(:dialogs_messages, on_delete: :delete_all), null: false
      timestamps()
    end

  end
end
