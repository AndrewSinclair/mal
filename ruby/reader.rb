class Reader
  def initialize(tokens)
    @tokens = tokens
    @ptr = 0
  end

  def next
    token = @tokens[@ptr]
    @ptr += 1
    token
  end

  def peek
    @tokens[@ptr]
  end
end

def read_str(line)
  tokens = tokenizer(line)
  reader = Reader.new(tokens)
  read_form(reader)
end

def tokenizer(line)
  regexp = /[\s,]*(~@|[\[\]{}()'`~^@]|"(?:\\.|[^\\"])*"|;.*|[^\s\[\]{}('"`,;)]*)/
  line.scan(regexp).collect{|x| x.join}[0...-1]
end

def read_form(reader)
  token = reader.peek

  if token == '(' then
    read_list(reader)
  else
    read_atom(reader)
  end
end

def read_list(reader)
  tokens = Array.new

  reader.next #pop off left paren
  mal_data = read_form(reader)

  while not mal_data  == ')'
    tokens.push(mal_data)
    mal_data = read_form(reader)
  end
  tokens
end

def read_atom(reader)
  token = reader.next
  if number_or_nil token then token.to_i
  else token end
end

def number_or_nil(string)
    Integer(string || '')
rescue ArgumentError
    nil
end

