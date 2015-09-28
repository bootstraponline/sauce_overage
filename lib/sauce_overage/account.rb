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

    def get_user
      get                 = Curl::Easy.new("https://saucelabs.com/rest/v1/users/#{user}")
      get.http_auth_types = :basic
      get.username        = user
      get.password        = key
      get.verbose         = true # display more info on errors
      # Work around
      # /.rvm/gems/ruby-2.2.2/gems/curb-0.8.8/lib/curl/easy.rb:72:in `perform': SSL connect error (Curl::Err::SSLConnectError)
      # by retrying for two minutes
      wait(120) { get.perform }

      result = JSON.parse(get.body_str || '{}')
      fail result['error'] if result['error']
      result
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
