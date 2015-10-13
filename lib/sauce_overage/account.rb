module SauceOverage
  class Account
    attr_reader :user, :key

    def initialize(opts = {})
      @user = opts.fetch(:user, sauce_user)
      fail 'Must provide user' unless user
      @user = user.strip

      @key = opts.fetch(:key, sauce_key)
      fail 'Must provide key' unless key
      @key = key.strip
    end

    MUTEX = Mutex.new

    def hurley_client
      MUTEX.synchronize do
        return @hurley_client if @hurley_client
        client                              = @hurley_client = Hurley::Client.new 'https://saucelabs.com/rest/v1/'
        client.header[:content_type]        = 'application/json'
        client.request_options.timeout      = 2 * 60
        client.request_options.open_timeout = 2 * 60
        client.url.user                     = user
        client.url.password                 = key

        # Ensure body JSON string is parsed into a hash
        # Detect errors and fail so wait_true will retry the request
        client.after_call do |response|
          response.body = MultiJson.load(response.body) rescue {}

          client_server_error = %i(client_error server_error).include? response.status_type
          body_error          = response.body['error']

          if client_server_error || body_error
            response_error = body_error || ''
            fail(::Errno::ECONNREFUSED, response_error)
          end
        end

        @hurley_client
      end
    end

    def get_user
      wait(2 * 60) { hurley_client.get("users/#{user}").body }
    end

    def minutes
      get_user['minutes'].to_i
    end

    def check minutes_limit = nil
      unless minutes_limit
        env           = ENV['SAUCE_OVERAGE_LIMIT']
        minutes_limit = env.to_i if env && !env.strip.empty?
      end

      fail 'minutes limit must be set' unless minutes_limit
      fail 'minutes limit must be an int' unless minutes_limit.is_a?(Integer)

      remaining_minutes = minutes

      if remaining_minutes < minutes_limit
        fail "#{minutes_limit} minute limit breached (#{remaining_minutes} remaining)"
      end

      nil
    end
  end
end
