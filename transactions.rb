def assert(bool)
    raise RuntimeError unless bool
end

class Transaction
    attr_reader :previous, :from, :to

    def initialize(previous:, from:, to:)
        @previous = previous
        @from = from
        @to = to
    end
end

t = Transaction.new(previous: nil, from: "Alice", to: "Bob")
assert t.from == "Alice"
assert t.to == "Bob"
