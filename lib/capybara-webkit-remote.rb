require 'capybara'
require 'capybara-webkit'
require 'capybara/driver/remote_webkit'
require 'capybara/driver/webkit/remote_browser'


module Capybara
  module Driver
    module Webkit
      def self.connect_to(hostname, port, options = { })
        options[:remote_host] = hostname
        options[:remote_port] = port
        return Capybara::Driver::RemoteWebkit.new(nil, options)
      end
    end
  end
end