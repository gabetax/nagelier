module Nagelier
  class Application
    def initialize(user)
      @user = user
    end

    def start
      puts "we're not using this yet, but here's some stats:"
      puts client.activity_statistics

      io = SerialPortBuilder.get
      (1..256).each do |i|
        puts "#{i} (hit enter for next, ctrl+c to exit)"
        io.write i.to_s
        $stdin.gets
      end
    end

    def client
      @client ||= Fitgem::Client.new FitBitApiCredentials.new(@user).client_credentials
    end

  end
end
