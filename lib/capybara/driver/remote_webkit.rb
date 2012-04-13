class Capybara::Driver::RemoteWebkit < Capybara::Driver::Webkit
  attr_reader :browser, :hostname, :port
  def initialize(app, options = { })
    @app = app
    @options = options
    @hostname = options[:remote_host].to_s
    @port = options[:remote_port].to_i
    @rack_server = @app.nil? ? nil : Capybara::Server.new(@app)
    @rack_server.boot if (@rack_server and Capybara.run_server)
    @browser = Capybara::Driver::Webkit::RemoteBrowser.new(@hostname, @port, options)
  end
end