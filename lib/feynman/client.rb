require "net/http"
MAPPING=[:verb,:path,:proto]

class Client

  def handle(client, thost = '127.0.0.1', tport = nil)
      puts "Accepted connection from #{client.addr[3]}"
      inq = Hash[MAPPING.zip(client.gets.split)]
      uri = URI("http://#{thost}:#{tport}#{inq[:path]}")
      Net::HTTP.start(uri.host, uri.port) do |h|
        req = Net::HTTP::Get.new(uri) if inq[:verb] = "GET"
        res = h.request(req)
        client.write("HTTP/#{res.http_version} #{res.code} #{res.message}\n")
        puts "HTTP/#{res.http_version} #{res.code} #{res.message}\n"
        client.write("Content-type: #{res.content_type}\n")
        client.write("Content-length: #{res.content_length}\n\n")
        client.write("#{res.body}")
        client.close
      end
  end
end