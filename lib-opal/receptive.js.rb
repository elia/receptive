require 'console'
require 'receptive/jquery'

module Receptive
  def self.silence_logs
    debug = $DEBUG
    $DEBUG = false
    yield
    $DEBUG = debug
  end
end

require 'receptive/view'
require 'receptive/app'
