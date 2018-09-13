
defmodule ForthAle.SPI do
  @enforce_keys [:pid]
  defstruct @enforce_keys
end

defimpl HalIO, for: ForthAle.SPI do
  alias ElixirALE.SPI

  def read(device, read_count) do
    read_data = :binary.copy(<<0>>, read_count)
    SPI.transfer(device.pid, read_data)
    |> ForthAle.ok_bin_result()
  end

  def write(device, value) do
    SPI.transfer(device.pid, value)
    |> ForthAle.ok_bin()
  end

  def xfer(device, value) do
    SPI.transfer(device.pid, value)
    |> ForthAle.ok_bin_result()
  end
end

