module Nagelier
  class Application
    def initialize(user)
      @user = user
    end

    def start
      puts "we're not using this yet, but here's some stats:"
      puts client.activity_statistics

      io = SerialPortBuilder.get
      demo io
    end

    def demo(io)
      (0..255).each do |i|
        puts "#{i} (hit enter for next, ctrl+c to exit)"
        # IO#write calls #to_s on its input
        io.write i.chr
        puts "read: " + io.read_nonblock(1024).inspect rescue Errno::EAGAIN
        sleep 0.5
      end
    end

    def client
      @client ||= Fitgem::Client.new FitBitApiCredentials.new(@user).client_credentials
    end

  end
end
