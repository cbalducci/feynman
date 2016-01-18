require "./feynman/version"
require "./feynman/fproxy"
require "./feynman/config"
module Feynman
  config = Config.new(ARGV.shift || "feynman.yml")
  proxy = FProxy.new
  proxy.start(config.local_port)
end
