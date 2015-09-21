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
  end
end
