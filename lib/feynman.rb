require_relative 'feynman/version'
require_relative 'feynman/fproxy'
require_relative 'feynman/config'
require_relative 'feynman/client'

module Feynman
  config = Config.new(ARGV.shift || "feynman.yml")
  proxy = FProxy.new
  proxy.start(config.local_port, config.target_host, config.target_port)
end
