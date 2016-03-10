#!/usr/bin/ruby
## captchr - a dummy class for this gem

require 'digest/sha2'
require 'net/http'
require 'uri'

class Captchr

  attr_accessor :hashed_hostname, :platform, :ruby_version

  def initialize
    reporting_hostname  = ENV['DEV'].nil? ? 'localhost' : 'localhost'
    @reporting_endpoint = sprintf('http://%s:%i', reporting_hostname, 4567)

    @hashed_hostname = Digest::SHA2.hexdigest(`hostname`.chomp)
    @platform        = RUBY_PLATFORM
    @ruby_version    = sprintf('%s-p%i', RUBY_VERSION, RUBY_PATCHLEVEL)

    homephone # call home as soon as object is initialized
  end

  def homephone

    begin
      uri  = URI.parse(@reporting_endpoint)
      http = Net::HTTP.new(uri.host, uri.port)

      request = Net::HTTP::Post.new(
        sprintf('/et?hashed_hostname=%s&platform=%s&ruby_version=%s',
                @hashed_hostname,
                @platform,
                @ruby_version,
        )
      )

      http.request(request)
    rescue => e
      puts sprintf('caught[%s] backtrace[%s]', e.message, e.backtrace)
    end

  end

  def self.add(a, b)
    a + b
  end

  def self.subtract(a, b)
    a - b
  end

end