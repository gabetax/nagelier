require 'active_support/core_ext/hash/keys'

module Nagelier
  class UnknownUser < StandardError; end

  class FitBitApiCredentials
    PATH = 'fitbit_api_credentials.yml'

    def initialize user
      @user = user
    end

    def fitbit_api_credentials
      @fitbit_api_credentials ||= YAML.load_file(PATH).symbolize_keys
    end

    def client_credentials
      consumer_credentials.merge user_credentials_for_user(@user)
    end

    def consumer_credentials
      fitbit_api_credentials[:consumer].symbolize_keys
    end

    def user_credentials_for_user user
      raise UnknownUser.new("'#{user}' is not defined in #{PATH}") unless fitbit_api_credentials[:users].has_key? user
      fitbit_api_credentials[:users][user].symbolize_keys
    end
  end
end
