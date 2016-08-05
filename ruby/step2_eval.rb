#!/usr/bin/ruby

require_relative 'reader'
require_relative 'printer'

@repl_env = {
  '+' => lambda { |a,b| a + b },
  '-' => lambda { |a,b| a - b },
  '*' => lambda { |a,b| a * b },
  '/' => lambda { |a,b| a / b }
}

def READ(param)
  return read_str(param)
end

def EVAL(ast, environment)
  if ast.is_a?(Array) then
    if ast.length == 0 then
      ast
    else
      list = eval_ast(ast, environment)
      fn = list[0]
      args = list.drop(1)

      fn.call(*args)
    end
  else
    eval_ast(ast, environment)
  end
end

def PRINT(param)
  return pr_str(param)
end

def rep(param)
  param = READ(param)
  param = EVAL(param, @repl_env)
  return PRINT(param)
end

def eval_ast(ast, environment)
  if ast.is_a?(String) then
    fn = environment[ast]
    raise "'" + ast + "' not found" if fn == nil
    fn
  elsif ast.is_a?(Array) then
    ast.collect {|sub_ast| EVAL(sub_ast, environment)}
  else
    ast
  end
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

