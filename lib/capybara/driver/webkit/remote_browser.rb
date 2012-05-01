class Capybara::Driver::Webkit
  class RemoteBrowser < Capybara::Driver::Webkit::Browser
    attr :remote_host, :remote_port
    
    def self.open_sockets; @@_sockets ||= [ ]; end
    
    at_exit do
      socks = Capybara::Driver::Webkit::RemoteBrowser.open_sockets()
      while(socks.length > 0)
        s = socks.shift()
        s.close() rescue nil
      end
    end
    
    def initialize(hostname, port, options = { })
      @remote_host = hostname
      @remote_port = port
      super(options)
      Capybara::Driver::Webkit::RemoteBrowser.open_sockets << @socket
    end
    
    def disconnect!
      @socket.close rescue nil
      Capybara::Driver::Webkit::RemoteBrowser.open_sockets.delete(@socket)
      true
    end
    
    def start_server ; end
    
    def attempt_connect
      @socket = @socket_class.open(remote_host, remote_port)
      rescue Errno::ECONNREFUSED
    end
  end 
end