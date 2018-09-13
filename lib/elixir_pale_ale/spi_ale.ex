defmodule ForthAle.SPI do
  @enforce_keys [:pid, :cs]
  defstruct @enforce_keys
end

defimpl HalIO, for: ForthAle.SPI do
  @spec read(self :: pid(), count :: non_neg_integer()) :: {:ok, binary} | {:error, term}
  def read(device, read_count) do
    Serial.write(device.pid, [read_count, device.spi_dev_name, "|spi-read"])
    value = Serial.read(device.pid, 3) |> :binary.list_to_bin()

    {:ok, value}
  end

  @spec write(self :: pid(), data :: binary()) :: :ok | {:error, term}
  def write(device, value) do
    bytelst = :binary.bin_to_list(value)
    bytecnt = Enum.count(bytelst)
    Serial.write(device.pid, [bytelst, bytecnt, device.spi_dev_name, "|spi-write"])
    :ok
  end

  @spec xfer(self :: pid(), data :: binary()) :: {:ok, binary} | {:error, term}
  def xfer(device, value) do
    bytelst = :binary.bin_to_list(value)
    bytecnt = Enum.count(bytelst)
    Serial.write(device.pid, [bytelst, bytecnt, device.spi_dev_name, "|spi-write"])
    [value] = Serial.read(device.pid, 1)
    {:ok, value}
  end
end
