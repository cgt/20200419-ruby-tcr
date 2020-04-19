puts "Hello, World!"

def assert(bool)
    raise RuntimeError unless bool
end

assert true
