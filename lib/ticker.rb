require 'httparty'
require 'blockchain'
require 'pp'
require 'sequel'

class Ticker
  include HTTParty
  include Blockchain
  DB = Sequel.connect("postgres://julia@localhost/gecko_app_development")

  def insert
    DB[:archives].insert(response: request, timestamp: Time.now)
  end

  def request
    url = "https://blockchain.info/ticker"
    response = Net::HTTP.get_response(URI.parse(url))
    data = JSON.parse(response.body)
    data.each{|k,v| v.delete("symbol")}
    data.keys.each do |key|
      data[key] = Hash[data[key].map { |k, v| [k, (v * 100).round]}]
    end
    data.to_s.gsub('15m', 'p15m')
  end

end
