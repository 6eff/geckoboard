require_relative "../lib/ticker.rb"

feature "Blockchain data can be pushed to Geckoboard" do
  describe "reading db data" do
    before :each do
      response = "{\"USD\"=>{\"p15m\"=>61400, \"last\"=>61400, \"buy\"=>61283, \"sell\"=>61400}}"
      timestamp = "2016-10-01 19:48:28 +0300"
      DB[:archives].insert(response: response, timestamp: timestamp)
      Board.send(:remove_const, 'DB')
      Board::DB = Sequel.connect("postgres://julia@localhost/gecko_app_test")
    end

    it "parses data from db to JSON" do
      board = Board.new
      expect(board.retrieve_updates).to include(include(:response=>{"USD"=>{"p15m"=>61400, "last"=>61400, "buy"=>61283, "sell"=>61400}}))
      expect(board.retrieve_updates.first).to be_an_instance_of Hash
    end
  end

  describe "#create_dataset" do
    it "creates dataset on Geckoboard" do
    board = Board.new
    expect(board.create_dataset("SGD")).to be_an_instance_of Geckoboard::Dataset
    end
  end

  describe "#put_dataset" do
    it "adds data to dataset" do
    board = Board.new
    board.create_dataset("SGD")
    expect(board.put_dataset("SGD")).to be true
    board.delete_dataset("SGD")
    end
  end
end
