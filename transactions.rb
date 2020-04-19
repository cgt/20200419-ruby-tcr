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

a = Transaction.new(previous: nil, from: "Alice", to: "Bob", points: 2)
assert a.previous == nil
assert a.from == "Alice"
assert a.to == "Bob"

b = Transaction.new(previous: a, from: "Bob", to: "Alice", points: 2)
assert b.previous == a


class Transactions
    def initialize
        @transactions = []
    end

    def send_points(from:, to:, points:)
        t = Transaction.new(previous: last, from: from, to: to, points: points)
        @transactions << t
    end

    def amount
        @transactions.size
    end

    def last
        @transactions.last
    end

    def balance(account)
        0
    end
end

x = Transactions.new
assert x.amount == 0

assert x.balance("Bob") == 0

x.send_points(from: "Alice", to: "Bob", points: 2)
assert x.amount == 1
t1 = x.last
assert t1.from == "Alice"
assert t1.previous == nil

x.send_points(from: "Bob", to: "Alice", points: 2)
assert x.amount == 2
t2 = x.last
assert t2.from == "Bob"
assert t2.previous == t1
