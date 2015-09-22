require_relative 'spec_helper'

module SauceOverage
  describe Account do
    def account
      return @@account if defined?(@@account)
      @@account = Account.new user: 'myuser', key: 'mykey'
    end

    it 'defines version and date string constants' do
      expect(VERSION).to be_a String
      expect(DATE).to be_a String
    end

    it 'validates username/password' do
      expect { Account.new user: nil, key: '' }.to raise_error RuntimeError
      expect { Account.new user: '', key: nil }.to raise_error RuntimeError
      expect { Account.new user: nil, key: nil }.to raise_error RuntimeError
      expect { Account.new user: '', key: '' }.not_to raise_error
    end

    it 'errors when getting an invalid user' do
      user  = account.user
      key   = account.key
      error = 'Unauthorized; invalid access key or password'

      stub_request(:get, "https://#{user}:#{key}@saucelabs.com/rest/v1/users/#{user}")
        .to_return(status: 401, body: %({"error": "#{error}"}))

      expect { account.get_user }.to raise_error RuntimeError, error
    end

    def _398
      398
    end

    def _400
      400
    end

    def stub_valid_get_user
      user = account.user
      key  = account.key

      stub_request(:get, "https://#{user}:#{key}@saucelabs.com/rest/v1/users/#{user}")
        .to_return(status: 200, body: %({"minutes": #{_398}}))
    end

    it 'minutes succeeds when using a valid user' do
      stub_valid_get_user
      expect(account.minutes).to eq(_398)
    end

    it 'check succeeds when minutes are above limit' do
      stub_valid_get_user
      expect(account.check(300)).to eq(nil)
    end

    it 'check errors when minute limit is breached' do
      stub_valid_get_user
      error = "#{_400} minute limit breached (#{_398} remaining)"
      expect { account.check(_400) }.to raise_error RuntimeError, error
    end

    it 'check reads limit from env var correctly' do
      stub_valid_get_user
      _500                       = 500

      # verify explicit limit is used instead of env var
      ENV['SAUCE_OVERAGE_LIMIT'] = _500.to_s
      error                      = "#{_400} minute limit breached (#{_398} remaining)"
      expect { account.check(_400) }.to raise_error RuntimeError, error

      # verify env var is used as fallback when there's no explicit limit
      error = "#{_500} minute limit breached (#{_398} remaining)"
      expect { account.check }.to raise_error RuntimeError, error

      # verify empty env var
      error = 'minutes limit must be set'
      [' ', '', nil].each do |value|
        ENV['SAUCE_OVERAGE_LIMIT'] = value
        expect { account.check }.to raise_error RuntimeError, error
      end
    end
  end
end
