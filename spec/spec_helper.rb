# rubygems
require 'bundler/setup'
require 'pry'
require 'webmock/rspec'

require 'coveralls'
Coveralls.wear!

# internal
require_relative '../lib/sauce_overage'
