require_relative 'spec_helper'

module SauceOverage
  describe Account do
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

    it 'attempts to check an account' do
      user = 'myuser'
      key = 'mykey'

      stub_request(:get, "https://#{user}:#{key}@saucelabs.com/rest/v1/users/#{user}").
         to_return(body: '{"error": "Unauthorized; invalid access key or password"}')

      account = Account.new user: user, key: key
      account.get_user
    end
  end
end
