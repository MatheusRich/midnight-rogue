require 'simplecov'
SimpleCov.start

require "minitest/autorun"
require "minitest/unit"
require "mocha/minitest"
require_relative "../play.rb"

class TestHelper < Minitest::Test
end
