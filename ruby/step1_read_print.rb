#!/usr/bin/ruby

require_relative 'reader'
require_relative 'printer'

def READ(param)
  return read_str(param)
end

def EVAL(param)
  return param
end

def PRINT(param)
  return pr_str(param)
end

def rep(param)
  param = READ(param)
  param = EVAL(param)
  return PRINT(param)
end

begin
  print "user> "
  line = gets

  if line then
    output = rep line
    puts output
  end
end while line
print "\n"

