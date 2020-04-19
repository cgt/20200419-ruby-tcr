def assert(bool)
    raise RuntimeError unless bool
end

class Transaction
    attr_reader :from, :to

    def initialize(from:, to:)
        @from = from
        @to = to
    end
end

t = Transaction.new(from: "Alice", to: "Bob")
assert t.from == "Alice"
assert t.to == "Bob"
