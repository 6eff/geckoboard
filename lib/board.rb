require 'geckoboard'
require 'sequel'

class Board

  attr_reader :board_datasets
  DB = Sequel.connect("postgres://julia@localhost/gecko_app_development")

  def initialize
    @client = Geckoboard.client(ENV["api_key"])
    @board_datasets = {}
  end

  def create_dataset(code)
    @board_datasets[code] =
    @client.datasets.find_or_create("#{code.downcase}_set", fields: {
    "buy":{
      "type": "money",
      "name": "buy",
      "currency_code": code
        },
        "last":{
          "type": "money",
          "name": "last",
          "currency_code": code
            },
            "p15m":{
              "type": "money",
              "name": "p15min",
              "currency_code": code
                },
                "sell":{
                  "type": "money",
                  "name": "sell",
                  "currency_code": code
                    },
        timestamp: {
          type: :datetime,
          name: 'Time'
        }
      }
    )
  end

  def put_dataset(code)
    data = retrieve_updates
    extract = []
    processed = []
    data.each do |response|
      extract <<  slice(response, "timestamp".to_sym, "response".to_sym)
    end

    extract.each do |hash|
      processed << (hash[:response][code]).merge(slice(hash, "timestamp".to_sym))
    end
    @board_datasets.values_at(code)[0].put(processed)
  end

  def retrieve_updates
    DB[:archives].all.each do |hash|
      hash[:response] = JSON.parse hash[:response].gsub('=>', ':')
    end
  end

  def slice(hash, *keys)
    Hash[ [keys, hash.values_at(*keys)].transpose]
  end

  def delete_dataset code
    @client.datasets.delete("#{code.downcase}_set")
  end

  def ping
    @client.ping
  end

end
