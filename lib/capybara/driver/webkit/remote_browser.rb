class Capybara::Driver::Webkit
  class RemoteBrowser < Capybara::Driver::Webkit::Browser
    attr :remote_host, :remote_port
    def initialize(hostname, port, options = { })
      @remote_host = hostname
      @remote_port = port
      super(options)
    end
    
    def start_server ; end
    
    def attempt_connect
      @socket = @socket_class.open(remote_host, remote_port)
      rescue Errno::ECONNREFUSED
    end
  end 
end