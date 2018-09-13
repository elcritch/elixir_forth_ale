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

  def byte_list(data) do
    for i <- data, into: "" do
      <<i::size(1)-unit(1)>>
    end
  end
end
