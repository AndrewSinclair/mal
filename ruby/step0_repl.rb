#!/usr/bin/ruby

def READ(param)
  return param
end

def EVAL(param)
  return param
end

def PRINT(param)
  return param
end

def rep(param)
  param = READ(param)
  param = EVAL(param)
  param = PRINT(param)
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

