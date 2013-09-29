module Nagelier
  class Application
    def initialize(user)
      @user = user
    end

    def start
      puts client.activity_statistics
    end

    def client
      @client ||= Fitgem::Client.new FitBitApiCredentials.new(@user).client_credentials
    end

  end
end
