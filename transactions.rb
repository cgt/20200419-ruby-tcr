def assert(bool)
    raise RuntimeError unless bool
end

def assert_throws(&block)
    begin
        block.call
    rescue
    end
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


class NameAlreadyInUse < RuntimeError
end

class Bank
    def initialize
        @transactions = []
        @accounts = []
    end

    def send_points(from:, to:, points:)
        t = Transaction.new(previous: last_transaction, from: from, to: to, points: points)
        @transactions << t
    end

    def transactions
        @transactions.size
    end

    def last_transaction
        @transactions.last
    end

    def balance(account)
        deposits(account) - withdrawals(account)
    end

    def open_account(name)
        if @accounts.find { |account| account == name }.nil?
            @accounts << name
        else
            raise NameAlreadyInUse.new
        end
    end

    private

    def deposits(account)
        @transactions
            .select { |t| t.to == account }
            .map { |t| t.points }
            .reduce(0) { |sum, points| sum + points }
    end

    def withdrawals(account)
        @transactions
            .select { |t| t.from == account }
            .map { |t| t.points }
            .reduce(0) { |sum, points| sum + points }
    end
end

bank = Bank.new
assert bank.transactions == 0

bank.open_account("Alice")
bank.open_account("Bob")

assert bank.balance("Alice") == 0
assert bank.balance("Bob") == 0

begin
    bank.open_account("Alice")
rescue NameAlreadyInUse
else
    fail "should not be allowed to open account with name already in use"
end

bank.send_points(from: "Alice", to: "Bob", points: 2)
assert bank.transactions == 1
t1 = bank.last_transaction
assert t1.from == "Alice"
assert t1.previous == nil

assert bank.balance("Alice") == -2
assert bank.balance("Bob") == 2

bank.send_points(from: "Bob", to: "Alice", points: 2)
assert bank.transactions == 2
t2 = bank.last_transaction
assert t2.from == "Bob"
assert t2.previous == t1

assert bank.balance("Bob") == 0
assert bank.balance("Alice") == 0
