module Nagelier
  class Application
    def initialize(user)
      @user = user
    end

    def start
      io = SerialPortBuilder.get
      # io ||= $stdout

      query = ArduinoStatisticsQuery.new(todays_activities)

      while true
        byte = query.output_byte_for_arduino
        io.write byte
        puts   query.debug_stats
        puts "Wrote: #{byte.ord}"
        sleep 60
      end
    end

    def demo(io)
      (0..255).each do |i|
        puts "#{i} (hit enter for next, ctrl+c to exit)"
        # IO#write calls #to_s on its input
        io.write i.chr
        puts "read: " + io.read_nonblock(1024).inspect rescue Errno::EAGAIN
        sleep 0.1
      end
    end

    def fitbit_client
      @fitbit_client ||= Fitgem::Client.new FitBitApiCredentials.new(@user).client_credentials
    end

    def todays_activities
      fitbit_client.activities_on_date Date.today
    end
  end
end
