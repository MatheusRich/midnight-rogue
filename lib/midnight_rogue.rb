require 'colored2'
require 'io/console' 
require_relative "midnight_rogue/battle"
require_relative "midnight_rogue/player"
require_relative "midnight_rogue/helper"

include Helper

trap "SIGINT" do
  exit_game
end
