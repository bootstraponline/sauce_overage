require_relative 'sauce_utils'

module SauceOverage
  class Account
    include SauceOverage::SauceUtils

    attr_reader :user, :key

    def initialize opts={}
      @user = opts.fetch(:user, sauce_user)
      fail 'Must provide user' unless user
      user.strip!

      @key = opts.fetch(:key, sauce_key)
      fail 'Must provide key' unless key
      key.strip!
    end

    def get_user
      get                 = Curl::Easy.new("https://saucelabs.com/rest/v1/users/#{user}")
      get.http_auth_types = :basic
      get.username        = user
      get.password        = key
      get.perform

      JSON.parse(get.body_str || '{}')
    end
  end
end
