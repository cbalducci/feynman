require "./feynman/version"
require "socket"
require "uri"

module Feynman

  class FProxy
    def start(port)
      puts "Creating listening TCP socket on #{port}"
      @sock=TCPServer.open(port)
      loop {
        Thread.start(@sock.accept) { |c| handle(c) }
      }
    end

    def handle(client)
      loop {
        to_server=TCPSocket.new("127.0.0.1","4567")
        request = client.readline
        puts "Asking for #{request}"
        to_server.write(request)
        response = to_server.read
        puts "Got answer #{response}"
      }
    end
  end

proxy = FProxy.new
proxy.start(1099)
end
