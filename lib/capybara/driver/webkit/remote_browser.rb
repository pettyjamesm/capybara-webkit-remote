class Capybara::Driver::Webkit
  class RemoteConnection < Capybara::Driver::Webkit::Connection
    def self.open_sockets; @@_sockets ||= [ ]; end
    at_exit do
      socks = Capybara::Driver::Webkit::RemoteConnection.open_sockets()
      while(socks.length > 0)
        s = socks.shift()
        s.close() rescue nil
      end
    end
    def initialize(remote_host, remote_port, options)
      @remote_host = remote_host
      @remote_port = remote_port
      super(options)
      Capybara::Driver::Webkit::RemoteConnection.open_sockets << @socket
    end
    def close
      @socket.close rescue nil
      Capybara::Driver::Webkit::RemoteConnection.open_sockets.delete(@socket)
      true
    end
    def start_server ; end
    def attempt_connect
      @socket = @socket_class.open(@remote_host, @remote_port)
      rescue Errno::ECONNREFUSED
    end
  end
  
  class RemoteBrowser < Capybara::Driver::Webkit::Browser
    attr :remote_host, :remote_port
    
    def initialize(hostname, port, options = { })
      @connection = Capybara::Driver::Webkit::RemoteConnection.new(hostname, port, options)
      super(@connection)
    end
    
    def disconnect!
      @connection.close rescue nil
      true
    end
  end 
end