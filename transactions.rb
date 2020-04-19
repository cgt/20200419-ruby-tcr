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
    def initialize
        @transactions = []
    end

    def add(transaction)
        @transactions << transaction
    end
end

x = Transactions.new
x.add t
x.add t2
