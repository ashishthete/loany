defmodule Loany.Repo.Migrations.AddStatusAndInterestFieldInApplicationTable do
  use Ecto.Migration

  def change do
    alter table(:applications) do
      add :status, :string
      add :interest, :decimal
    end
  end
end
