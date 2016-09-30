require "./lib/ticker.rb"
require "./lib/board.rb"


def every_n_minutes(n)
  loop do
    before = Time.now
    yield
    interval = (n*60 - (Time.now - before))
    sleep(interval) if interval > 0
  end
end


ticker = Ticker.new
board = Board.new
board.create_dataset(ARGV[1])

every_n_minutes(ARGV[0].to_i) do
  ticker.insert
  board.put_dataset(ARGV[1])
end
