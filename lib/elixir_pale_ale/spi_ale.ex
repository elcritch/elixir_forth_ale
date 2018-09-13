defmodule ForthAle.SPI do
  @enforce_keys [:pid, :cs]
  defstruct @enforce_keys
end

defimpl HalIO, for: ForthAle.SPI do

  def read(device, read_count) do
    read_data = :binary.copy(<<0>>, read_count)

    GPIO.write(device.select_pin, 0)

    res =
      SPI.transfer(device.pid, read_data)
      |> ForthAle.ok_bin_result()

    GPIO.write(device.select_pin, 1)

    res
  end

  def write(device, value) do
    GPIO.write(device.select_pin, 1)

    res =
      SPI.transfer(device.pid, value)
      |> ForthAle.ok_bin()

    GPIO.write(device.select_pin, 1)

    res
  end

  def xfer(device, value) do
    GPIO.write(device.select_pin, 1)

    res =
      SPI.transfer(device.pid, value)
      |> ForthAle.ok_bin_result()

    GPIO.write(device.select_pin, 1)

    res
  end
end
