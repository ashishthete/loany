defmodule Loany.Controller.Cache do
    use GenServer

    alias Loany.Repo

    import Ecto.Query
  
    alias Loany.Model.Application

    @default_lowest_amount 0

    def add(amount) do
        GenServer.cast(__MODULE__, {:add, amount})
    end

    def get(field) do
        GenServer.call(__MODULE__, field)
    end

    def start_link(_) do
        GenServer.start_link(__MODULE__, 0, name: __MODULE__)
    end
    
    # Callbacks
  
    @impl true
    def init(_) do
        min = get_min_loan_amount()
        {:ok, %{min: min}}
    end
  
    @impl true
    def handle_call(:min_loan_amount, _from, %{min: min}=state) do
        {:reply, min, state}
    end
  
    @impl true
    def handle_cast({:add, amount}, %{min: min} = state) do
        case amount < min do
            true ->
                {:noreply, %{state | min: amount}}
            false
                {:noreply, state}
        end
    end

    defp get_min_loan_amount() do
        query =
            Application
            |> select([p], min(p.amount))
        
        case Repo.one(query) do
            nil -> @default_lowest_amount
            amount -> amount
        end
    end
end