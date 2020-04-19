def assert(bool)
    raise RuntimeError unless bool
end

assert true

class Transaction
    attr_reader :from

    def initialize(from:)
        @from = from
    end
end

assert Transaction.new(from: "Alice").from == "Alice"
