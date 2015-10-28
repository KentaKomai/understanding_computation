
require './number'
require './boolean'
require './variable'
require './add'
require './multiply'
require './less_than'
require './assign'
require './sequence'
require './variable'
require './while'


p Number.new(5).to_ruby
p Boolean.new(false).to_ruby
proc = eval(Number.new(5).to_ruby)
p proc
p proc.call({})

proc =  eval(Boolean.new(false).to_ruby)
p proc
p proc.call({})


expression = Variable.new(:x)
p expression
p expression.to_ruby
proc = eval(expression.to_ruby)
p proc
p proc.call({x:7})


environment = {x:3}
proc = eval(Add.new(Variable.new(:x), Number.new(1)).to_ruby)
p proc
p proc.call(environment)

proc = eval(LessThan.new(Add.new(Variable.new(:x), Number.new(1)), Number.new(3)).to_ruby)
p proc
p proc.call(environment)

statement = Assign.new(:y, Add.new(Variable.new(:x), Number.new(1)))
p statement
p statement.to_ruby
proc = eval(statement.to_ruby)
p proc
p proc.call({x:3})


statement = While.new(
  LessThan.new(Variable.new(:x), Number.new(5)),
  Assign.new(:x, Multiply.new(Variable.new(:x), Number.new(3)))
)
p statement
p statement.to_ruby
proc = eval(statement.to_ruby)
p proc
p proc.call({x:1})