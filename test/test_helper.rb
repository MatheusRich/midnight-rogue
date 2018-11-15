require 'simplecov'
SimpleCov.start

require "minitest/autorun"
require "minitest/unit"
require "mocha/minitest"
require_relative "../lib/midnight_rogue.rb"

class TestHelper < Minitest::Test
end
