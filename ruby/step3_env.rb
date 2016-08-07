#!/usr/bin/ruby

require_relative 'reader'
require_relative 'printer'
require_relative 'env'

@repl_env = Env.new(nil)
@repl_env.set('+', lambda { |a,b| a + b })
@repl_env.set('-', lambda { |a,b| a - b })
@repl_env.set('*', lambda { |a,b| a * b })
@repl_env.set('/', lambda { |a,b| a / b })


def READ(param)
  return read_str(param)
end

def EVAL(ast, env)
  if ast.is_a?(Array) then
    if ast.length == 0 then
      ast
    else
      head = ast[0]
      if head == "def!" then
        env.set(ast[1], EVAL(ast[2], env))
      elsif head == "let*" then
        env2 = Env.new(env)
        bindings = ast[1]
        bindings.each_slice(2).to_a.each do |binding|
          key = binding[0]
          val = binding[1]
          val = EVAL(val, env2)
          env2.set(key, val)
        end
        EVAL(ast[2], env2)
      else
        list = eval_ast(ast, env)
        fn = list[0]
        args = list.drop(1)
        fn.call(*args)
      end
    end
  else
    eval_ast(ast, env)
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

def eval_ast(ast, env)
  if ast.is_a?(String) then
    fn = env.get(ast)
    raise "'" + ast + "' not found" if fn == nil
    fn
  elsif ast.is_a?(Array) then
    ast.collect {|sub_ast| EVAL(sub_ast, env)}
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

