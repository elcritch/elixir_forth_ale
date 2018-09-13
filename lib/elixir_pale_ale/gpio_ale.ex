defmodule ForthAle.GPIO do
  @enforce_keys [:pid, :pin]
  defstruct @enforce_keys
end

defimpl HalIO, for: ForthAle.GPIO do
  @spec read(self :: pid(), count :: non_neg_integer()) :: {:ok, binary} | {:error, term}
  def read(device, _read_count \\ 1) do
    Serial.write(device.pid, [device.pin_name, "|pin-read"])
    [value] = Serial.read(device.pid, 1)

    {:ok, value}
  end

  def write(device, value) when is_bitstring(value) do
    write(device, :binary.at(value, 0))
  end

  @spec write(self :: pid(), data :: binary()) :: :ok | {:error, term}
  def write(device, value) do
    Serial.write(device.pid, [value, device.pin_name, "|pin-write"])
    :ok
  end

  def xfer(device, value) when is_bitstring(value) do
    xfer(device, :binary.at(value, 0))
  end

  @spec xfer(self :: pid(), data :: binary()) :: {:ok, binary} | {:error, term}
  def xfer(device, value) do
    write(device, value)
    result = read(device, value)

    result
  end
end
