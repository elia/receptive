# frozen_string_literal: true

require 'receptive/version'
require 'opal'

module Receptive
  PATHS = ["#{__dir__}/../lib-opal".freeze]

  def self.paths
    PATHS
  end
end

Receptive.paths.each { |path|  Opal.append_path path }
