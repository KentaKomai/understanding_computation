
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


p 'supported Number by big step semantics'
number = Number.new(23).evaluate({})
p number

p 'supported Variable by big step semantics'
variable = Variable.new(:x).evaluate({x: Number.new(23)})
p variable

p 'supported LessTha, Add, Multiply by big step semantics'
expression = LessThan.new(
  Add.new(Variable.new(:x), Number.new(2)),
  Variable.new(:y)
).evaluate({x: Number.new(2), y:Number.new(5)})
p expression

p 'supported Sequence by big step semantics'
assign = Assign.new(:x, Add.new(Number.new(1) , Number.new(1)))
p assign
p assign.evaluate({})
statement = Sequence.new(
  Assign.new(:x, Add.new(Number.new(1) , Number.new(1))),
  Assign.new(:y, Add.new(Variable.new(:x), Number.new(3)))
)
p statement
p statement.evaluate({})

p 'supported While statement by big step semantics'
while_state =  While.new(
  LessThan.new(Variable.new(:x), Number.new(5)),
  Assign.new(:x, Multiply.new(Variable.new(:x), Number.new(3)))
)
p while_state
p while_state.evaluate({x: Number.new(1)})
