defmodule Loany.Model.Application do
    use Ecto.Schema
    import Ecto.Changeset

    @primary_key {:id, :binary_id, autogenerate: true}
    @derive {Phoenix.Param, key: :id}
  
    schema "applications" do
      field :names, {:array, :string}
      field :email, :string
      field :phone, :string
      field :amount, :integer

      field :status, :string
      field :interest, :decimal

      timestamps()
    end
  
    @doc false
    def changeset(application, attrs) do
      application
      |> cast(attrs, [:names, :email, :phone, :amount, :status, :interest])
      |> validate_required([:names, :email, :phone, :amount])
      |> validate_number(:amount, greater_than: 0)
      |> validate_format(:phone, ~r/^\+[1-9]\d{9,14}$/,
        message: "Invalid phone number"
      )
      |> validate_format(:email, ~r/^[A-Za-z0-9\._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}$/,
        message: "Invalid Email Address"
      )
    end
  end
  