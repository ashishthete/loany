defmodule Loany.Controller.Score do
  @moduledoc """
  The Loan Application Score.
  """
  alias Loany.Controller.Cache

  def get(amount) when is_binary(amount) do
    {amount, _} = Integer.parse(amount, 10)
    get(amount)
  end
  def get(amount) when is_integer(amount) do
    case amount < Cache.get(:min_loan_amount) do
        true ->
            Cache.add(amount)
            {:rejected, :lowest_amount_requested}
        false ->
            {:accepted, get_interest_rate(amount)}
    end
  end

  defp get_interest_rate(amount) do
    case is_prime(amount) do
        true ->
            9.99
        false ->
            Enum.random(4..12)
    end
  end

  defp is_prime(2), do: true
  defp is_prime(x) when x > 2 do
    2..div(x, 2)
    |> Enum.filter(fn a -> rem(x, a) == 0 end)
    |> length() == 1
  end
  defp is_prime(_), do: false
end