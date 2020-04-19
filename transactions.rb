def assert(bool)
    raise RuntimeError unless bool
end

class Transaction
    attr_reader :previous, :from, :to, :points

    def initialize(previous:, from:, to:, points:)
        @previous = previous
        @from = from
        @to = to
        @points = points
    end
end

t = Transaction.new(previous: nil, from: "Alice", to: "Bob", points: 2)
assert t.previous == nil
assert t.from == "Alice"
assert t.to == "Bob"

t2 = Transaction.new(previous: t, from: "Bob", to: "Alice", points: 2)
assert t2.previous == t


class Transactions
    attr_reader :transactions

    def initialize
        @transactions = []
    end

    def send_points(from:, to:, points:)
        t = Transaction.new(previous: nil, from: from, to: to, points: points)
        @transactions << t
    end

    def amount
        @transactions.size
    end

    def last
        @transactions.last
    end
end

x = Transactions.new
assert x.amount == 0

x.send_points(from: "Alice", to: "Bob", points: 2)
assert x.amount == 1
assert x.last.from == "Alice"

x.send_points(from: "Bob", to: "Alice", points: 2)
assert x.amount == 2
