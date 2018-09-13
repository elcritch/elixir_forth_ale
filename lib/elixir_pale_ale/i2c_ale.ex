defmodule ForthAle.I2C do
  @enforce_keys [:pid, :bus_name]
  defstruct @enforce_keys ++ [:address]
end

defimpl HalIO, for: ForthAle.I2C do
  alias ElixirALE.I2C

  def read(device, read_count) do
    I2C.read(device.pid, read_count)
  end

  def write(%{address: nil} = device, val) do
    I2C.write(device.pid, val)
  end

  def xfer(%{address: nil} = device, value) do
    I2C.write_read(device.pid, value, byte_size(value))
  end
end

defmodule ForthAle.I2C.Addr do
  @enforce_keys [:pid, :bus_name, :address]
  defstruct @enforce_keys
end

defimpl HalIO, for: ForthAle.I2C.Addr do
  alias ElixirALE.I2C

  def read(%{address: addr} = device, read_count) do
    I2C.read_device(device.pid, addr, read_count)
    |> ForthAle.ok_bin_result()
  end

  def write(%{address: addr} = device, val) do
    I2C.write_device(device.pid, addr, val)
    |> ForthAle.ok_bin()
  end

  def xfer(%{address: addr} = device, value) do
    I2C.write_read_device(device.pid, addr, value, byte_size(value))
    |> ForthAle.ok_bin_result()
  end
end

