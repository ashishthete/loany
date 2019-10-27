defmodule Loany.Repo.Migrations.CreateApplications do
  use Ecto.Migration

  def change do
    create table(:applications, primary_key: false) do
      add :id,    :uuid, primary_key: true
      add :names, {:array, :string}
      add :email, :string
      add :phone, :string
      add :amount, :integer

      timestamps()
    end

  end
end
