require_relative "../lib/ticker.rb"


feature "Blockchain API consumption" do
  describe 'Blockchain API request' do
    it 'returns a list of currencies with market info' do
      ticker = Ticker.new
      response = ticker.request
      expect(response).to be_an_instance_of(String)
    end
  end

  describe "response is stored into database" do
    before :each do
      response = "Blockchain API response"
      timestamp = "2016-10-01 19:48:28 +0300"
      DB[:archives].insert(response: response, timestamp: timestamp)
    end
    it 'stores response string and timestamp to database' do
      expect(DB[:archives].first).to include :timestamp => Time.new(2016,10,01,19,48,28, "+03:00"), :response => "Blockchain API response"
    end
  end
end
