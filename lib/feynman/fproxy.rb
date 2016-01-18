require "socket"

class FProxy

  def start(port, thost, tport)
    puts "Creating listening TCP socket on #{port}"
    @sock=TCPServer.open(port)
    loop {
      Thread.start(@sock.accept) do |c| 
        client = Client.new
        client.handle(c, thost, tport) 
      end
    }
  rescue Interrupt
    puts "Interrupt received"
  ensure
    @sock.close if @sock
    puts "Gracefully dying"
  end

end