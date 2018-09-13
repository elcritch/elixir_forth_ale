
defmodule ForthAle.GPIO do
  @enforce_keys [:pid, :pin]
  defstruct @enforce_keys
end

defimpl HalIO, for: ForthAle.GPIO do
  alias ElixirALE.GPIO

  def read(device, _read_count \\ 1) do
    case GPIO.read(device.pid) do
      res when is_integer(res) ->
        {:ok, << res >>}
      err ->
        err
    end
  end

  def write(device, value) when is_bitstring(value) do
    write(device, :binary.at(value, 0))
  end
  def write(device, value) do
    GPIO.write(device.pid, value)
  end

  def xfer(device, value) when is_bitstring(value) do
    xfer(device, :binary.at(value, 0))
  end
  def xfer(device, value) do
    rres = GPIO.read(device.pid)
    wres = GPIO.write(device.pid, value)

    cond do
      is_integer(rres) and wres == :ok ->
        {:ok, << rres >>}
      is_integer(rres) ->
        wres
      wres == :ok ->
        rres
    end
  end
end

