# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Mechat.Repo.insert!(%Mechat.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Mechat.Accounts
alias Mechat.Dialogs
Accounts.create_user(%{username: "chernyshof", email: "chernyshof@gmail.com", password: "12345678"})
Accounts.create_user(%{username: "misha", email: "muha@gmail.com", password: "12345678"})
Dialogs.create_dialog(%{user_1_id: 1, user_2_id: 2})
Dialogs.create_user_messages(%{user_id: 1, dialog_id: 1, body: "test1"})
Dialogs.create_user_messages(%{user_id: 2, dialog_id: 1, body: "test2"})
Dialogs.create_user_messages(%{user_id: 1, dialog_id: 1, body: "test3"})
