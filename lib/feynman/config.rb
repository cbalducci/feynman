require "yaml"

class Config
  attr_reader :config, :local_port, :target_host, :target_port, :docker_host, :docker_port, :docker_ssl
  def initialize(c="feynman.yml")
    config = File.open(c) { |y| YAML::load(y)}
    @local_port = config["local"]["port"]
    @target_host = config["target"]["host"]
    @target_port = config["target"]["port"]
    @docker_host = config["docker"]["host"]
    @docker_port = config["docker"]["port"]
    @docker_ssl = config["docker"]["ssl"]
  end
end
