$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "receptive"

# require "minitest/autorun"
require 'opal/platform'
require 'minitest'

`if (typeof(window) === 'undefined') window = Opal.global;` # for nodejs
at_exit { Minitest.run ARGV; exit `Opal.global.OPAL_TEST_EXIT_STATUS` || 1 }
