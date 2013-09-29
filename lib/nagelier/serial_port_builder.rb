module Nagelier
  class SerialPortBuilder
    DEFAULTS = {
      device_path: '/dev/tty.usbmodem1421',
      baud_rate:   9600,
      data_bits:   8,
      stop_bits:   1,
      parity:      SerialPort::NONE
    }

    def self.get(options)
      options.reverse_merge!(DEFAULTS)
      SerialPort.new(
        options[:device_path],
        options[:baud_rate],
        options[:data_bits],
        options[:stop_bits],
        options[:parity]
      )
    end
  end
end
