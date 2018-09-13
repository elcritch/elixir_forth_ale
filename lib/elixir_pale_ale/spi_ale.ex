defmodule ForthAle.SPI do
  @enforce_keys [:pid, :cs]
  defstruct @enforce_keys
end

defimpl HalIO, for: ForthAle.SPI do

  @spec read(self :: pid(), count :: non_neg_integer() ) :: {:ok, binary} | {:error, term}
  def read(device, read_count) do
    read_data = :binary.copy(<<0>>, read_count)

    GPIO.write(device.select_pin, 0)

    res =
      SPI.transfer(device.pid, read_data)
      |> ForthAle.ok_bin_result()

    GPIO.write(device.select_pin, 1)

    res
  end

  @spec write(self :: pid(), data :: binary() ) :: :ok | {:error, term}
  def write(device, value) do
    GPIO.write(device.select_pin, 1)

    res =
      SPI.transfer(device.pid, value)
      |> ForthAle.ok_bin()

    GPIO.write(device.select_pin, 1)

    res
  end

  @spec xfer(self :: pid(), data :: binary() ) :: {:ok, binary} | {:error, term}
  def xfer(device, value) do
    GPIO.write(device.select_pin, 1)

    res =
      SPI.transfer(device.pid, value)
      |> ForthAle.ok_bin_result()

    GPIO.write(device.select_pin, 1)

    res
  end
end
