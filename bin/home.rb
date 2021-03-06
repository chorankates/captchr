#!/usr/bin/ruby
# home.rb is the server side of captchr, listens for ET. loves reeses pieces.

DESMOND = sprintf('sqlite://%s', File.join(sprintf('%s/../bike.db', File.dirname(__FILE__))))

require 'sequel'
require 'sinatra'

class PhoneHome

  attr_reader :db

  def initialize(db = DESMOND)
    @db = Sequel.connect(db)

    # create a table if necessary
    @db.create_table? :entries do
      primary_key :id
      String :hashed_hostname
      String :ip
      String :platform
      String :ruby_version
      String :geolocation
      Date :created
      Date :updated
    end
  end

  # +phe+ a PhoneHomeEntry
  def add_entry(phe)
    self.db[:entries].insert(
      :hashed_hostname => phe.hashed_hostname,
      :ip              => phe.ip,
      :platform        => phe.platform,
      :ruby_version    => phe.ruby_version,
      :geolocation     => nil,
      :created         => Time.now,
      :updated         => nil,
    )
  end

end

class PhoneHomeEntry
  attr_reader :created, :geolocation, :hashed_hostname, :ip, :platform, :ruby_version

  def initialize(hashed_hostname, ip, platform, ruby_version, geolocation = nil)
    @created         = Time.now
    @geolocation     = geolocation
    @hashed_hostname = hashed_hostname
    @ip              = ip
    @platform        = platform
    @ruby_version    = ruby_version
  end

end

## initialize some helpers
ph = PhoneHome.new()

post '/et' do

  ip = self.request.env['REMOTE_ADDR']

  hashed_hostname = params[:hashed_hostname]
  platform        = params[:platform]
  ruby_version    = params[:ruby_version]

  # TODO error checking? .. it should just be us calling us, but..

  phe = PhoneHomeEntry.new(hashed_hostname, ip, platform, ruby_version)
  ph.add_entry(phe)
  phe # return the object we created
end

configure do
  set :bind, '0.0.0.0'
end

# don't respond to anything except what we've defined
error Sinatra::NotFound do
  content_type 'text/plain'
  [404, '']
end
