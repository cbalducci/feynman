require "socket"
require "net/http"

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