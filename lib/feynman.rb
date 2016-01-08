require "./feynman/version"
require "socket"
require "net/http"
require "yaml"

module Feynman

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

  class FProxy

    def start(port)
      puts "Creating listening TCP socket on #{port}"
      @sock=TCPServer.open(port)
      loop {
        Thread.start(@sock.accept) { |c| handle(c) }
      }
    rescue Interrupt
      puts "Interrupt received"
    ensure
      @sock.close if @sock
      puts "Gracefully dying"
    end

    def handle(client)
      puts "Accepted connection from #{client}"
      uri = URI("http://127.0.0.1:4567/movies")
      Net::HTTP.start(uri.host, uri.port) do |h|
        req = Net::HTTP::Get.new(uri)
        res = h.request(req)
        client.write("HTTP/#{res.http_version} #{res.code} #{res.message}\n")
        client.write("Content-type: #{res.content_type}\n")
        client.write("Content-length: #{res.content_length}\n\n")
        client.write("#{res.body}")
        client.close
      end
    end
  end

config = Config.new(ARGV.shift || "feynman.yml")
proxy = FProxy.new
proxy.start(config.local_port)
end
