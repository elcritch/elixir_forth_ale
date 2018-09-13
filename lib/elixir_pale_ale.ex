defmodule ForthAle do
  @moduledoc """
  Documentation for "Elixir"ForthAle.
  """

  def ok_bin(response) when is_bitstring(response) do
    :ok
  end

  def ok_bin(response), do: response

  def ok_bin_result(response) when is_bitstring(response) do
    {:ok, response}
  end

  def ok_bin_result(response), do: response

end
